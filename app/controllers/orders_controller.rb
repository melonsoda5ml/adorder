require 'viewpoint'
include Viewpoint::EWS

class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

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
  end

  def create
		set_order(order_params)
		redirect_to action:'index'
    #respond_with(@order)
  end

  def update
    @order.update(order_params)
    respond_with(@order)
  end

  def destroy
    @order.destroy
    respond_with(@order)
  end

  private
    def set_order(order_params)
#    @order = Order.find(params[:id])
			p order_params
			@order = Order.new
			@order.media = order_params[:media]
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
				m.body    = "申込です！！！！！"
				m.to_recipients << 'mozawa@nikkeibp.co.jp'
			end
    end

    def order_params
      params[:order]
    end

end
