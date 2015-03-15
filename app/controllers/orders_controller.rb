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
		@csv = CSV.read("config/csv_data/media.csv")
    @order = Order.new
    respond_with(@order)
  end

  def edit
		@csv = CSV.read("config/csv_data/media.csv")
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
		endpoint = 'https://outlook.office365.com/ews/Exchange.asmx'
		user = 'mozawa@nikkeibp.co.jp'
		pass = 'Kirei333'
		t = render_to_string('sendmail.text.erb', collection: [@order]).to_str
		cli = Viewpoint::EWSClient.new endpoint, user, pass
		date_ja =  @order.release_date.strftime("%Y/%m/%d(#{%w(日 月 火 水 木 金 土)[@order.release_date.wday]})")

		cli.send_message do |m|
			m.subject = "【申込み】"+@order.media
			m.body = t
			m.to_recipients << 'miyuki328@icloud.com'
			m.cc_recipients << 'mozawa@nikkeibp.co.jp'
			end
	end

  private

    def set_order(order)
			order.media = order_params[:media]
=begin
			year = params[:release_date]["{:use_month_numbers=>true, :start_year=>2014, :end_year=>2014, :default=>2014, :date_separator=>\"%s\"}(1i)"].to_i
			month = params[:release_date]["{:use_month_numbers=>true, :start_year=>2014, :end_year=>2014, :default=>2014, :date_separator=>\"%s\"}(2i)"].to_i
			date = params[:release_date]["{:use_month_numbers=>true, :start_year=>2014, :end_year=>2014, :default=>2014, :date_separator=>\"%s\"}(3i)"].to_i
			order.release_date = Date.new year, month, date
=end
			order.release_date = order_params[:release_date]
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
