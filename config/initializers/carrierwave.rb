CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: 'AKIAJW75RJ325TZWF5JA',
    aws_secret_access_key: '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',
    region: 'sa-east-1'
  }

  # For testing, upload files to local `tmp` folder.
  if Rails.env.test? || Rails.env.development?
    config.storage           = :file
    config.enable_processing = false
    config.root              = "#{Rails.root}/tmp"
  else
    config.storage = :fog
  end

  config.cache_dir        = "#{Rails.root}/tmp/uploads" # To let CarrierWave work on Heroku
  config.fog_directory  = 'vitrineonline'
  config.fog_public     = true
  config.fog_attributes = {'Cache-Control' => 'max-age=315576000'}
end





#CarrierWave.configure do |config|
  #if Rails.env.production?

  #  config.storage = :fog

  #  config.fog_credentials = {
  #    provider: 'AWS',
  #    aws_access_key_id: 'AKIAJW75RJ325TZWF5JA',
  #    aws_secret_access_key: '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',
  #    region: 'sa-east-1'
  #  }
  #  config.fog_directory  = 'vitrineonline'
  #  config.fog_public     = true
  #  config.fog_attributes = {'Cache-Control' => 'max-age=315576000'}

#  else
    # for development and testing locally
    #config.storage = :file
  #  config.enable_processing = true

#end
#end
