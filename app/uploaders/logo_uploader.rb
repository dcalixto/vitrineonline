# encoding: utf-8
require 'carrierwave/orm/activerecord'
class LogoUploader < CarrierWave::Uploader::Base

   include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
 

   def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    '/assets/fallback/' + [version_name, 'logo.png'].compact.join('_')
  end

  # Create different versions of your uploaded files:
   version :thumb do
    process resize_to_fit: [156, 114]
    process quality: 80

    process :strip
   end



version :show do
    process resize_to_fit: [180, 150]
    process quality: 80

    process :strip
   end


   version :mobile do
    process resize_to_fit: [126, 64]
    process quality: 80

    process :strip
   end
  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
