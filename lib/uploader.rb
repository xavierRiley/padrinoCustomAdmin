class Uploader < CarrierWave::Uploader::Base

  ##
  # Image manipulator library:
  #
  # include CarrierWave::RMagick
  # include CarrierWave::ImageScience
  include CarrierWave::MiniMagick
  
  IMAGE_EXTENSIONS = %w(jpg jpeg gif png)
  DOCUMENT_EXTENSIONS = %w(exe pdf doc docm xls)
  AUDIO_EXTENSIONS = %w(mp3 wma ogg wav)
  VIDEO_EXTENSIONS = %w(mp4 mov)

  ##
  # Storage type
  #
  storage :file
  # configure do |config|
  #   config.fog_credentials = {
  #     :provider              => 'XXX',
  #     :aws_access_key_id     => 'YOUR_ACCESS_KEY',
  #     :aws_secret_access_key => 'YOUR_SECRET_KEY'
  #   }
  #   config.fog_directory = 'YOUR_BUCKET'
  # end
  # storage :fog



  ## Manually set root
  def root; File.join(Padrino.root,"public/"); end

  ##
  # Directory where uploaded files will be stored (default is /public/uploads)
  # Some trickery needed here - dump all uploads in here and keep versions are kept in their respective folders
  #
  def store_dir
    'uploads/original_files'
  end

  ##
  # Directory where uploaded temp files will be stored (default is [root]/tmp)
  #
  def cache_dir
    Padrino.root("tmp")
  end

  ##
  # Default URL as a default if there hasn't been a file uploaded
  #
  # def default_url
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  ##
  # Process files as they are uploaded.
  #
  # process :resize_to_fit => [740, 580]

  ##
  # Create different versions of your uploaded files
  #
  # version :header do
  #   process :resize_to_fill => [940, 250]
  #   version :thumb do
  #     process :resize_to_fill => [230, 85]
  #   end
  # end
  ##
  # White list of extensions which are allowed to be uploaded:
  #
  def extension_white_list
    IMAGE_EXTENSIONS + DOCUMENT_EXTENSIONS + AUDIO_EXTENSIONS + VIDEO_EXTENSIONS
  end
  
  # create a new "process_extensions" method. It is like "process", except
  # it takes an array of extensions as the first parameter, and registers
  # a trampoline method which checks the extension before invocation
  def self.process_extensions(*args)
    extensions = args.shift
    args.each do |arg|
      if arg.is_a?(Hash)
        arg.each do |method, args|
          processors.push([:process_trampoline, [extensions, method, args]])
        end
      else
        processors.push([:process_trampoline, [extensions, arg, []]])
      end
    end
  end

  # our trampoline method which only performs processing if the extension matches
  def process_trampoline(extensions, method, args)
    extension = File.extname(original_filename).downcase
    extension = extension[1..-1] if extension[0,1] == '.'
    self.send(method, *args) if extensions.include?(extension)
  end
  
  # version actually defines a class method with the given block
  # therefore this code does not run in the context of an object instance
  # and we cannot access uploader instance fields from this block
  version :admin_thumb do
    # this isn't right 
    #process_extensions Uploader::IMAGE_EXTENSIONS, :resize_to_fit => [80,80], store_dir = "public/uploads/images/#{model.id}" 
    process_extensions Uploader::IMAGE_EXTENSIONS, :resize_to_fit => [80,80] 
  end

  #version :logo do
  #  process_extensions Uploader::IMAGE_EXTENSIONS, :resize_to_fit => [210,100]
  #end
  
  #version :thumb do
  #  process_extensions ImageUploader::IMAGE_EXTENSIONS, :resize_to_fill => [35, 35]
  #end

  ##
  # Override the filename of the uploaded files
  #
  # def filename
  #   "something.jpg" if original_filename
  # end
end
