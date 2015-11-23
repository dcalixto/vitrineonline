CarrierWave.configure do |config|
   
  if Rails.env.production?
  
  config.storage = :fog
  
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => ENV['AWS_ACCESS_KEY_ID'],
    :aws_secret_access_key  => ENV['AWS_SECRET_ACCESS_KEY'],
    :region                 => 'sa-east-1'
  }
  config.fog_directory  = 'vitrineonline'
  config.fog_public     = true

  
    else
 #for development and testing locally
  config.storage = :file
  config.enable_processing = true

end
end




