CarrierWave.configure do |config|
   
  if Rails.env.production?
  
  config.storage = :fog
  
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => 'AKIAJW75RJ325TZWF5JA',
    :aws_secret_access_key  => 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAljUUISRGaBGRf45PZl3A
lSUo5pLTwYHlSU3UQ5eD7/cmF8q3Ig0M5rQVfw0CPLg4kUzArKzv4cU0AgXqk2Mq
slrzrRPRVjYQeoPysXX3OCpvbVzSEyEPSOxeP6SAPPtpZZ0xj7umYR96zy8G2Ll+
vzGRbjRkVP8H5DpCFQOO6kA7ALiGM6pR8V0jmIxM4Jr1h+RGbH9xVAAIf3EN1wb1
y6AIGHxVYez4mGe7zpwp3pHukKwexUmH747PEYMrU3/MxUBR6bY3psP03AX6Qk7B
x/lx1I+4i4MH2ICJ0iNHFMSj2uPv9VXrTUeMyVm0+wYktVRMPzksNcbehmXO7N0j
pwIDAQAB',
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




