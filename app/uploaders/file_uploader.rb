# encoding: utf-8
require 'carrierwave/orm/activerecord'
class FileUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper

 
# include CarrierWave::Video

# process encode_video: [:mp4, callbacks: { after_transcode: :set_success } ]



  storage :file

  include CarrierWave::MimeTypes
  process :set_content_type

  
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end


  def default_url
    '/assets/fallback/' + [version_name, 'prova.png'].compact.join('_')
  end


#  process encode_video: [:mp4, resolution: "640x360"]

  version :thumb do
    process resize_to_fit: [150, 150]
    process quality: 80

    process :strip
  end


  version :big do
    process resize_to_fit: [460, 460]
    process quality: 80

    process :strip
  end


  def extension_white_list
    %w(jpg jpeg png )
  end


end

