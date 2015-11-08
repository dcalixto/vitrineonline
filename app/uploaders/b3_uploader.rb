# encoding: utf-8

class B3Uploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick
  include Sprockets::Helpers::RailsHelper
  # include CarrierWave::ImageOptimizer

  # Choose what kind of storage to use for this uploader:

  storage :file

  include CarrierWave::MimeTypes
  process :set_content_type

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    '/assets/fallback/' + [version_name, 'b3.svg'].compact.join('_')
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
