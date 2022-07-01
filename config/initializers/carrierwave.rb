CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV['ACCESS_KEY_ID'],
    aws_secret_access_key: ENV['SECRET_ACCESS_KEY'],
    region: ENV['REGION']  # リージョンの位置によって記述が異なります
  }

    case Rails.env
    when 'production'
        config.fog_directory  = 'misato11'
        config.asset_host = 'https://s3.amazonaws.com/misato11'
    end
end
