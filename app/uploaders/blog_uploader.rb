class BlogUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  process resize_to_fit: [690, 690]

  version :thumb do
    process resize_to_fill: [180, 135]
  end

  version :thumb_index do
    process resize_to_fill: [280, 193]
  end

  storage :file

  def store_dir
    if model.id.to_i < 1000
      "uploads/blog/0/00#{model.id}"
    else
      "uploads/blog/#{model.id.to_s[0..-4]}/00#{model.id}"
    end
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
  def filename
    "pic.jpg" if original_filename
  end

end
