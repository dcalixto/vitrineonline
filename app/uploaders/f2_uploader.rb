# encoding: utf-8
require 'carrierwave/orm/activerecord'

class F2Uploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper


  storage :file

  include CarrierWave::MimeTypes
  process :set_content_type


  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    '/assets/fallback/' + [version_name, 'f2.svg'].compact.join('_')
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
    process resize_to_fit: [264, 343]
    process quality: 80

    process :strip
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg png )
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end
