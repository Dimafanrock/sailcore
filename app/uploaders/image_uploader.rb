# app/uploaders/image_uploader.rb
class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage(Rails.env.local? ? :file : :aws)

  # Specify the directory where uploaded files will be stored
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Allow only image files
  def content_type_allowlist
    [%r{image/}]
  end

  # Restrict file extensions (optional but recommended)
  def extension_allowlist
    %w[jpg jpeg png]
  end

  # Create different versions of the uploaded file
  version :small do
    process resize_to_fill: [300, 300]
  end

  # Configure AWS S3 (if you are using it for production)
  def aws_bucket
    ENV.fetch('SAILCORE_S3_IMAGE_BUCKET', nil)
  end
end
