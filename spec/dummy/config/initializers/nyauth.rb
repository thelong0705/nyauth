Nyauth.configure do |config|
  # Ruby2.3以前では、文字長が多い場合、それ以降の文字を切り捨てて動作してくれていたが、
  # Ruby2.4以降では、ArgumentErrorを返すようになったため、32文字指定にする
  encryption_secret = ENV['NYAUTH_ENCRYPTION_SECRET'] || 'rails6dd08eff1c2cf5aecb54cb1a97266817b58cc27f06be9e95918c06607d3950d623a4fd4c0c306d2216cdaf3f99871e21e0e975a5e64ef5cf286b68ed8d7379a4'
  config.encryption_secret = encryption_secret[0..31]
  config.use_cookie_auth = true
end
