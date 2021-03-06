require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      # Amazon S3用の設定
      :provider => 'AWS',
      :region => ENV['AWS_REGION'],  # S3に設定したリージョン。
      :aws_access_key_id => ENV['AWS_ACCESS_KEY_ID'],
      :aws_secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
    }
    config.fog_directory = ENV['AWS_BUCKET']
    config.asset_host = 'https://s3.amazonaws.com/misato11'
    config.fog_public = false
    config.storage :fog
    config.fog_provider = 'fog/aws'
  end
end
