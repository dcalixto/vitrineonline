class ImageUploader < Shrine
  include ImageProcessing::MiniMagick

  plugin :determine_mime_type
  plugin :store_dimensions
  plugin :direct_upload, presign: true, max_size: 20*1024*1024
  plugin :versions, names: [:original, :thumb]
  plugin :remove_attachment
  plugin :logging

  def process(io, context)
    case context[:phase]
    when :promote
      thumb = resize_to_limit!(io.download, 300, 300)
      {original: io, thumb: thumb}
    end
  end

  def process(io, context)
    if context[:phase] == :store
      with_minimagick do |image| # yields a MiniMagick::Image
        image.quality("80")
      end
    end
end
