require 'viewpoint'
include Viewpoint::EWS

class OrdersController < ApplicationController
#  before_action :set_order, only: :create

  respond_to :html

  def index
    @orders = Order.all
    respond_with(@orders)
  end

  def show
    respond_with(@order)
  end

  def new
    @order = Order.new
    respond_with(@order)
  end

  def edit
		@order = Order.find(params[:id])
  end

  def create
		set_order(order_params)
		redirect_to action:'index'
    #respond_with(@order)
  end

  def update
		@order = Order.find(params[:id])
    #@order.update(order_params)
    #respond_with(@order)
  end

def destroy
#    @order.destroy
		Order.find(params[:id]).destroy
		flash[:success] = "オーダーを削除しました"
#    respond_with(@order)
		redirect_to orders_path
  end

  private
    def set_order(order_params)
#    @order = Order.find(params[:id])
			p order_params
			@order = Order.new
			@order.media = order_params[:media]
			#@release_date = Date.civil(params[:release_date][:"date(1i)"].to_i, params[:release_date][:"date(2i)"].to_i, params[:release_date][:"date(3i)"].to_i)
			p @release_date
			@order.release_date = order_params[:release_date]
			@order.client = order_params[:client]
			@order.agent = order_params[:agent]
			@order.space = order_params[:space]
			@order.price = order_params[:price]
			@order.rate = order_params[:rate]
			@order.account = order_params[:account]
			@order.sample = order_params[:sample]
			@order.user_id = current_user.id
			@order.save
			#UserMailer.sendmail(@order).deliver

			endpoint = 'https://outlook.office365.com/ews/Exchange.asmx'
			user = 'mozawa@nikkeibp.co.jp'
			pass = 'Kirei333'
			cli = Viewpoint::EWSClient.new endpoint, user, pass
			cli.send_message do |m|
				m.subject = "【申込み】"+@order.media
				m.body    = current_user.name+"から申込みです！！！！！"
				m.to_recipients << 'mozawa@nikkeibp.co.jp'
			end
    end

    def order_params
      params[:order]
    end

end
