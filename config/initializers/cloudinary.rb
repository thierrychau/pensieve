Cloudinary.config do |config|
  config.cloud_name = ENV["CLOUDINARY_CLOUD_NAME"]
  config.api_key = ENV["CLOUDINARY_API_KEY"]
  config.api_secret = ENV["CLOUDINARY_API_SECRET"]
  config.cdn_subdomain = true
  config.secure = true
end

Cloudinary.config_from_url(ENV['CLOUDINARY_URL'])
pp "Initializer: cloudinary #{Cloudinary.config.cloud_name}"
