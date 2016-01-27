class FileUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  process resize_to_fit: [680, 500]

  version :thumb do
    process resize_to_fit: [500, 400]
  end

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
  def filename
    "pic.jpg" if original_filename
  end


end
