class UserMailer < ApplicationMailer
	default from: "mozawa@nikkeibp.co.jp"
	def sendmail(order)
		@order = order
		subject = "【申込み】"+@order.media
		mail(
			to:'mozawa@nikkeibp.co.jp',
			subject: subject
		)
	end
end
