# encoding: utf-8
require 'carrierwave/orm/activerecord'
class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper


  storage :file

  include CarrierWave::MimeTypes
  process :set_content_type


  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end


  def default_url
    '/assets/fallback/' + [version_name, 'image.png'].compact.join('_')
  end



  version :thumb do
    process resize_to_fit: [170, 198]
    process quality: 80

    process :strip
  end

  version :small do
    process resize_to_fit: [80, 100]
    process quality: 80
    process :strip
  end



  version :big do
    process resize_to_fit: [460, 543]
    process quality: 80

    process :strip
  end


  def extension_white_list
    %w(jpg jpeg png )
  end


end
