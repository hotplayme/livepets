class PetUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  process resize_to_fit: [880, 880]

  version :thumb_880 do
    process resize_to_fill: [880, 495]
  end

  version :thumb_600 do
    process resize_to_fill: [600, 432]
  end

  version :thumb_280 do
    process resize_to_fill: [280, 201]
  end

  version :thumb_200 do
    process resize_to_fill: [200, 200]
  end

  version :thumb_185 do
    process resize_to_fill: [180, 135]
  end

  version :thumb_174 do
    process resize_to_fill: [174, 120]
  end

  version :thumb_135 do
    process resize_to_fit: [135, 300]
  end

  version :thumb_70 do
    process resize_to_fill: [70, 70]
  end

  storage :file

  def store_dir
    if model.id.to_i < 1000
      "uploads/pet/0/00#{model.id}"
    else
      "uploads/pet/#{model.id.to_s[0..-4]}/00#{model.id}"
    end
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def filename
    "pic.jpg" if original_filename
  end

end
