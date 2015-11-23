# encoding: utf-8
require 'carrierwave/orm/activerecord'

class B2Uploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick
  include Sprockets::Helpers::RailsHelper
  

  storage :file

  include CarrierWave::MimeTypes
  process :set_content_type

 
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    '/assets/fallback/' + [version_name, 'b2.svg'].compact.join('_')
   end

  version :thumb do
    process resize_to_fit: [760, 250]
    process quality: 85

    process :strip
  end

  version :small do
    process resize_to_fit: [225, 105]
    process quality: 85

    process :strip
  end
end
