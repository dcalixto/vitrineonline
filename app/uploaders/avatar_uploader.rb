# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper

  # Choose what kind of storage to use for this uploader:

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

  # def default_url
  #  image = [version_name, "avatar.svg"].compact.join('_')
  #  "http://s3.amazonaws.com/#{ENV['vitrineonline-assets']}/assets/fallback/#{image}"
  # end

  # asset_path("fallback/" + [normal, "avatar.svg"].compact.join('_'))

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  # "/images/fallback/" + [small, "small_avatar_default.png"].compact.join('_')
  # #"/images/fallback/" + [medium, "medium_avatar_default.png"].compact.join('_')
  # "/images/fallback/" + [large, "large_avatar_default.png"].compact.join('_')
  # end

  version :message do
    process resize_to_fit: [50, 50]
    process quality: 80

    process :strip
  end

  version :post do
    process resize_to_fit: [100, 100]
    process quality: 85

    process :strip
  end

  version :small do
    process resize_to_fit: [30, 30]
    process quality: 85

    process :strip
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg png svg)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end
