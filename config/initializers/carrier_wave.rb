CarrierWave.configure do |config|
  if Rails.env.test?
    config.storage = :file
    config.enable_processing = false
  else
    config.storage = :aws
    config.asset_host = ENV.fetch('SAILCORE_AWS_ASSET_HOST', nil)

    config.aws_credentials = {
      access_key_id: ENV.fetch('SAILCORE_AWS_ACCESS_KEY_ID', nil),
      secret_access_key: ENV.fetch('SAILCORE_L_AWS_SECRET_ACCESS_KEY', nil),
      region: ENV.fetch('SAILCORE_AWS_REGION', nil)
    }

    config.aws_attributes = {
      expires: 1.week.from_now.httpdate,
      cache_control: 'max-age=604800'
    }
  end
end
