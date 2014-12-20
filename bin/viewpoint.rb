require 'viewpoint'
include Viewpoint::EWS

endpoint = 'https://outlook.office365.com/ews/Exchange.asmx'
user = 'mozawa@nikkeibp.co.jp'
pass = 'Kirei333'

cli = Viewpoint::EWSClient.new endpoint, user, pass
cli.send_message subject: "テスト！？！？！", body: "Test", to_recipients: ['mozawa@nikkeibp.co.jp']
