Paapi.configure do |config|
  config.access_key = ENV['AMAZONAPI_ACCESS_KEY']
  config.secret_key = ENV['AMAZONAPI_SECRET_KEY']
  config.partner_tag = ENV['AMAZONAPI_ASSOCIATE_TAG']
end