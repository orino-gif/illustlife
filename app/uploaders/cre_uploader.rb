class CreUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  include CarrierWave::MiniMagick
  
  # 保存形式をpngにする
  process :convert => 'png'

  # Choose what kind of storage to use for this uploader:
  # if Rails.env.development?
    storage :file
    # storage :fog
  # else
  # storage :fog
  # end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.id}/#{mounted_as}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  
  # サムネイル保存する
  
    # def cache_dir
    #   "/local#{model.class.to_s.underscore}/#{model.id}/#{mounted_as}"
    # end
  
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :thumb400 do
    process :resize_to_limit => [400, 400]
  end
  
  version :thumb250 do
    process :resize_to_limit => [250, 250]
  end
  
  version :thumb50 do
    process :resize_to_limit => [50, 50]
  end

  # Add an allowlist of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_allowlist
    %w(png jpg jpeg gif)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # 拡張子が同じでないとGIFをJPGとかにコンバートできないので、ファイル名を変更
  def filename
    super.chomp(File.extname(super)) + '.png' if original_filename.present?
  end
  
  def size_range
    1..100.megabytes
  end
end
