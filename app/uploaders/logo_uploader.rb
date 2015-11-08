# encoding: utf-8

class LogoUploader < CarrierWave::Uploader::Base
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
    '/assets/fallback/' + [version_name, 'logo.svg'].compact.join('_')
  end

  version :thumb do
    process resize_to_fit: [100, 60]
    process quality: 80
    process :strip
  end

  private

  # Simplest way


  def extension_white_list
    %w(jpg jpeg png svg)
  end
end
