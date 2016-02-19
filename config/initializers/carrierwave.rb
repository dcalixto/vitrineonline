CarrierWave.configure do |config|
  if Rails.env.production?

    config.storage = :fog

    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: 'AKIAJW75RJ325TZWF5JA',
      aws_secret_access_key: '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',
      region: 'sa-east-1'
    }
    config.fog_directory  = 'vitrineonline'
    config.fog_public     = true

  else
    # for development and testing locally
    config.storage = :file
    config.enable_processing = true

end
end
