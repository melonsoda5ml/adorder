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
	if @order.type == 0
		@type = MEDIATYPE_MAGAZINE
		print "雑誌を表示\n"
	elsif @order.type == 1
		@type = MEDIATYPE_WEB
		print "ウェブを表示\n"
	end
	
	respond_with(@order)
  end

  def new
	#@m = Medium.find_by(:type=>0)
	#puts @m
	puts Medium.all
	respond_with(@order)
  end

  def edit
	@mag = CSV.read("config/csv_data/mag.csv")
	@web = CSV.read("config/csv_data/web.csv")
	@order = Order.find(params[:id])
    respond_with(@order)
  end

  def create
  	@order = set_order(Order.new)
  	
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

def set_order(order)
print "メディアの種別="
print order_params[:media]

=begin
	print @mediatype
	if @mediatype == true #雑誌
		order.type = 0
		order.end_date = null
		print "雑誌を登録\n"
	else #Web
		order.type = 1
		order.end_date = order_params[:end_date]
		print "ウェブを登録\n"
	end
=end
    	order.media = order_params[:media]
    	order.start_date = order_params[:start_date]
    	order.client = order_params[:client]
    	order.agent = order_params[:agent]
    	order.space = order_params[:space]
    	order.margin = order_params[:margin]
    	order.price = order_params[:price]
    	order.rate =  params[:rate][:count].to_i
    	order.account = order_params[:account]
    	order.production = order_params[:production]
    	order.sample = order_params[:sample]
    	order.placement_report = order_params[:placement_report]
    	order.attribution_report = order_params[:attribution_report]
    	order.download_pdf = order_params[:download_pdf]
    	order.clickcount = order_params[:clickcount]
    	order.notes = order_params[:notes]
    	order.user_id = current_user.id
    	order.status = params[:status][:count].to_i
    	order.save
	return order
    end

def order_params
    	params[:order]
end

end
