# encoding: utf-8
require 'carrierwave/orm/activerecord'

class B1Uploader < CarrierWave::Uploader::Base
   include CarrierWave::MiniMagick
  include Sprockets::Helpers::RailsHelper

  storage :file

  include CarrierWave::MimeTypes
  process :set_content_type

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    '/assets/fallback/' + [version_name, 'b1.svg'].compact.join('_')
   end

  version :thumb do
    process resize_to_fit: [800, 280]
    process quality: 80

    process :strip
  end

  version :small do
    process resize_to_fit: [225, 105]
    process quality: 80

    process :strip
  end
end
