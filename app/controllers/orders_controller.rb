require 'viewpoint'
include Viewpoint::EWS

class OrdersController < ApplicationController
#  before_action :set_order, only: :create
  respond_to :html

  def index
	@cases = Case.all
	@orders = Order.all
	respond_with(@orders)
  end

  def show
	@order = Order.find(params[:id])
	respond_with(@order)
  end

  def new
	respond_with(@order)
  end

  def edit
		@order = Order.find(params[:id])
		respond_with(@order)
  end

  def create 
	@case = Case.new(case_params)
	@case.pic_id = current_user.id
	@case.save

 	@order = Order.new(order_params)
	@order.case_id = @case.id
    	if @order.category == Order::MAGAZINE_SCHEME
    		@order.media = order_params[:media_mag]
    	elsif  @order.category == Order::WEB_SCHEME
    		@order.media = order_params[:media_web]
    	end
    	pp @order
   	@order.save
	if params[:mail][:send] == "1"
		#Mailer.sendmail(@order).deliver
		sendmail(@order)
	end
	redirect_to orders_path
	flash[:success] = "オーダーを登録しました"
  end

  def update
	@order = Order.find(params[:id])
	@order.update(order_params)
	if params[:mail][:send] == "1"
		#Mailer.sendmail(@order).deliver
		sendmail(@order)
	end
	redirect_to orders_path
	flash[:success] = "オーダーを編集しました"
  end

def destroy
	puts "ですとろい！！！"
	Order.find(params[:id]).destroy
	flash[:success] = "オーダーを削除しました"
	redirect_to orders_path
 end

def sendmail(order)
	@order = order
	endpoint = 'https://outlook.office365.com/ews/Exch' #Office365
	user = 'ユーザー名'
	pass = 'パスワード'
	t = render_to_string('sendmail.text.erb', collection: [@order]).to_str
	cli = Viewpoint::EWSClient.new endpoint, user, pass
	date_ja =  @order.release_date.strftime("%Y/%m/%d(#{%w(日 月 火 水 木 金 土)[@order.release_date.wday]})")

	cli.send_message do |m|
		m.subject = "【申込み】"+@order.media
		m.body = t
		m.to_recipients << '申込先Eメールアドレス'
	end
end

private

def case_params
params.require(:case).permit(:name, :client, :agent, :pic_id, :status)
end

def order_params
params.require(:order).permit(:media, :price, :margin, :rate, :notes, :media_mag, :media_web, :management_number, :month_of_bill, :address_of_bill, :case_id, :category)
end

end
