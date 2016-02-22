if (Rails.env.production? || Rails.env.staging?) && defined?(AssetSync)
AssetSync.configure do |config|
  config.fog_provider = 'AWS'
  config.aws_access_key_id = 'AKIAJW75RJ325TZWF5JA'
  config.aws_secret_access_key = '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'
  config.fog_directory = 'vitrineonline'
  config.fog_region = 'sa-east-1'
  config.existing_remote_files = "keep"
  config.gzip_compression = true
  config.fail_silently = true
end
end
