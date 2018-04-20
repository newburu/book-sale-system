Amazon::Ecs.options = {
  :associate_tag =>     ENV['AMAZONAPI_ASSOCIATE_TAG'],
  :AWS_access_key_id => ENV['AMAZONAPI_ACCESS_KEY'],
  :AWS_secret_key =>    ENV['AMAZONAPI_SECRET_KEY']
}