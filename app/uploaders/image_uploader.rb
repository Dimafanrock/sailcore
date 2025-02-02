class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage(Rails.env.local? ? :file : :aws)

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def content_type_allowlist
    [%r{image/}]
  end

  def extension_allowlist
    %w[jpg jpeg png]
  end

  version :small do
    process resize_to_fill: [300, 300]
  end

  def aws_bucket
    ENV.fetch('SAILCORE_S3_IMAGE_BUCKET', nil)
  end
end
