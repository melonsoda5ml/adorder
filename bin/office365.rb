require 'oauth'

client =OAuth2::Client.new(
	'd333b834-b522-46e4-9672-608ad9db1ac9',
	'LUWnGNrjLJAL8zkZor5pLjLbTRFENB4PlkpM4R405h4=',
	:site => "https://login.windows.net",
      :resource => "https://outlook.office365.com/",
      :authorize_url => '/common/oauth2/authorize'
)
redirect_uri = 'http://www.google.com'

authorize_url = client.auth_code.authorize_url(:redirect_uri => redirect_uri)
p authorize_url