require 'viewpoint'
require 'csv'
include Viewpoint::EWS

class OrdersController < ApplicationController
#  before_action :set_order, only: :create
  respond_to :html

  def index
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
  	@order = Order.new(order_params)
    	@order.user_id = current_user.id
    	if @order.type == 0
    		puts "雑誌"
    		puts order_params[:media_mag]
    		@order.media = order_params[:media_mag]
    	elsif @order.type == 1
    		puts "WEB"
    		puts order_params[:media_web]
    		@order.media = order_params[:media_web]
    	end
    	ap @order
  	@order.save
	if params[:mail][:send] == "1"
		#Mailer.sendmail(@order).deliver
		sendmail(@order)
	end
	redirect_to orders_path
	flash[:success] = "オーダーを登録しました"
  end

  def update
	@order = set_order(Order.find(params[:id]))
	if params[:mail][:send] == "1"
		#Mailer.sendmail(@order).deliver
		sendmail(@order)
	end
	redirect_to orders_path
	flash[:success] = "オーダーを編集しました"
  end

def destroy
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


def order_params
	params.require(:order).permit(:type, :status, :start_date, :end_date, :client, :agent, :price, :margin, :rate, :account, :sample, :production, :notes, :person_in_chage, :media_mag, :media_web)
end

end
