ActiveAdmin::Editor.configure do |config|
  config.s3_bucket = Settings.s3.upload_bucket
  config.aws_access_key_id = Settings.s3.access_key
  config.aws_access_secret = Settings.s3.secret_key
  config.storage_dir = 'uploads'
end
