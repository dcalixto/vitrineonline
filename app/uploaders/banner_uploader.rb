#encoding: utf-8
require 'carrierwave/processing/mini_magick'
class BannerUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  #include CarrierWave::RMagick
  include CarrierWave::MiniMagick
  include Sprockets::Helpers::RailsHelper
  #include CarrierWave::ImageOptimizer

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
    "/assets/fallback/" + [version_name, "banner.svg"].compact.join('_')
  end



  # Provide a default URL as a default if there hasn't been a file uploaded:
  #def default_url
  # "/images/fallback/" + [small, "small_avatar_default.png"].compact.join('_')
  ##"/images/fallback/" + [medium, "medium_avatar_default.png"].compact.join('_')
  # "/images/fallback/" + [large, "large_avatar_default.png"].compact.join('_')
  #end




  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end




  #Create different versions of your uploaded files:

  #process :quality => 100




  version :thumb do
    process :resize_to_fit => [760, 250]
    process :quality => 85

    process :strip

  end
 
  version :small do
    process :resize_to_fit => [225, 105]
    process :quality => 85

    process :strip

  end







  #end

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





