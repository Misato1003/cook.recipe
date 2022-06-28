CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => 'your_access_key_id',
    :aws_secret_access_key  => 'your_secret_access_key',
    :region                 => 'chosen_region'
  }

  config.fog_directory = 'your_backet' if Rails.env.production?
  config.fog_directory = 'your_backet_for_dev' if Rails.env.development?

end
