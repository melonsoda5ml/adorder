require 'viewpoint'
include Viewpoint::EWS

class OrdersController < ApplicationController
#  before_action :set_order, only: :create
  respond_to :html

  def index
	@cases = Case.where(pic_id: current_user.id)
	respond_with(@orders)
  end

  def show
  	@order = Order.find(params[:id])
	@case = Case.find(@order.case_id)
	#@mag = MagazineOrder.find_by_order_id(@order.id)
	@media_type = mediatype(@order)
	if @order.category == Order::MAGAZINE_SCHEME
		@mag = @order.magazine_orders.first
	elsif @order.category == Order::MAIL_SCHEME
		@mail = @order.mail_orders.first
	end
	@case_status = casestatus(@case)
	respond_with(@order)
  end

  def new
	respond_with(@order)
  end

  def edit
		@order = Order.find(params[:id])
		@case = Case.find(@order.case_id)
		respond_with(@order)
  end

  def create 
	@case = Case.new(case_params)
	@case.pic_id = current_user.id
	@case.save

 	@order = Order.new(order_params)
	@order.case_id = @case.id
	@order.save
	@media = createmedia(@order)
   	    	
	if params[:mail][:send] == "1"
		sendmail(@case,@order,@media)
	end
	redirect_to orders_path
	flash[:success] = "オーダーを登録しました"
  end

  def update
	@order = Order.find(params[:id])
	@case = Case.find(@order.case_id)
	
	@media_type = mediatype(@order)
	
	@order.update(order_params)
	@case.update(case_params)
	@media = updatemedia(@order)
	if params[:mail][:send] == "1"
		#Mailer.sendmail(@order).deliver
		sendmail(@case,@order,@media)
	end
	redirect_to orders_path
	flash[:success] = "オーダーを編集しました"
  end

def destroy
	o = Order.find(params[:id])
	c = Case.find(o.case_id)
	c.destroy
	o.destroy
	flash[:success] = "オーダーを削除しました"
	redirect_to orders_path
end

private
def casestatus(c)
	@case = c
	@case_status = nil
	if @case.status == Case::OK_SCHEME
		@case_status = "決定"
	elsif @case.status == Case::ALMOST_SCHEME
		@case_status = "角度高め"
	elsif @case.status == Case::PROPOSING_SCHEME
		@case_status = "提案中"
	end
	return @case_status
end

def mediatype(order)
	@order = order
	@media_type = nil
	if@order.category == Order::MAGAZINE_SCHEME
		@media_type = "雑誌広告"
	elsif @order.category == Order::WEB_SCHEME
		@media_type = "インターネット広告"
	elsif @order.category == Order::MAIL_SCHEME
		@media_type = "メール広告"
	end
	return @media_type
end

def createmedia(order)
	@order = order
    	if @order.category == Order::MAGAZINE_SCHEME
    		@order.media = order_params[:media_mag] 
    		@order.save
    		@mag = MagazineOrder.new(mag_params)
    		@mag.order_id = @order.id
    		@mag.save
    		pp @mag
    		return @mag
    	elsif  @order.category == Order::WEB_SCHEME
    		@order.media = order_params[:media_web]
    	elsif  @order.category == Order::MAIL_SCHEME
    		@order.media = order_params[:media_mail]
    		@order.save
    		@mail = MailOrder.new(mail_params)
    		@mail.order_id = @order.id
    		@mail.save
    		pp @mail
    		return @mail
    	end
end

def updatemedia(order)
	@order = order
    	if @order.category == Order::MAGAZINE_SCHEME
    		@order.media = order_params[:media_mag] 
    		@order.save
    		@mag = MagazineOrder.find_by_order_id(@order.id)
     		@mag.order_id = @order.id
    		@mag.update(mag_params)
    		return @mag
    	elsif  @order.category == Order::WEB_SCHEME
    		@order.media = order_params[:media_web]
    	elsif  @order.category == Order::MAIL_SCHEME
    		@order.media = order_params[:media_mail]
		@order.save
    		@mail = MailOrder.find_by_order_id(@order.id)
    		@mail.order_id = @order.id
    		@mail.update(mail_params)
    		return @mail
    	end
end

def sendmail(c,o,m)
	@case = c
	@order = o
	@media = m

	t = render_to_string('mail.text.erb', collection: [@case, @order, @media]).to_str
	cli = Viewpoint::EWSClient.new endpoint, user, pass

	cli.send_message do |m|
		m.subject = "【申込み】"+ Medium.find_by_shorten(@order.media).name+":"+@case.client
		m.body = t
		m.to_recipients << ''
		m.cc_recipients << current_user.email
	end
end

def case_params
params.require(:case).permit(:name, :client, :agent, :pic_id, :status)
end

def order_params
	params.require(:order).permit(:media, :price, :margin, :rate, :notes, :media_mag, :media_web, :media_mail, :management_number, :month_of_bill, :address_of_bill, :case_id, :category)
end

def mag_params
	params.require(:magazine_order).permit(:order_id, :issue, :release_date, :space, :ad_form, :production_costs, :production, :montgh_of_appropriation)
end

def mail_params
	params.require(:mail_order).permit(:send_date, :space)
end
end