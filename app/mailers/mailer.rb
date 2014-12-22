class Mailer < ApplicationMailer
	#default from: "mozawa@nikkeibp.co.jp"
	default from: "emapsaibou@gmail.com"
	def sendmail(order)
		@order = order
		subject = "【申込み】"+@order.media
		mail(
			#to:'mozawa@nikkeibp.co.jp',
			to:"emapsaibou@gmail.com",
			subject: subject
		)
	end
end
