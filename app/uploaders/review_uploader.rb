class ReviewUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  process resize_to_fit: [690, 690]

  version :thumb do
    process resize_to_fill: [180, 135]
  end

  storage :file

  def store_dir
    if model.id.to_i < 1000
      "uploads/review/0/#{model.id}"
    else
      "uploads/review/#{model.id.to_s[0..-4]}/#{model.id}"
    end
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
  def filename
    "pic.jpg" if original_filename
  end
end
