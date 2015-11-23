# encoding: utf-8
require 'carrierwave/orm/activerecord'

class AvatarUploader < CarrierWave::Uploader::Base
  
  include CarrierWave::MiniMagick
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper

  storage :file

  include CarrierWave::MimeTypes
  process :set_content_type

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    '/assets/fallback/' + [version_name, 'avatar.svg'].compact.join('_')
  end

  
  version :message do
    process resize_to_fit: [50, 50]
    process quality: 80

    process :strip
  end

  version :thumb do
    process resize_to_fit: [186, 186]
    process quality: 80

    process :strip
  end

  version :small do
    process resize_to_fit: [30, 30]
    process quality: 80

    process :strip
  end

   def extension_white_list
    %w(jpg jpeg png svg)
  end

end
