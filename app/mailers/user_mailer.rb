class UserMailer < ApplicationMailer
	default from: "328miyuki@gmail.com"
	def hello(order)
		@order = order
		subject = "【申込み】"
		mail(
			to:'mozawa@nikkeibp.co.jp',
			subject: subject
		)
	end
end
