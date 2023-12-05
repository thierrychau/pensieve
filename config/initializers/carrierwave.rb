require "carrierwave"
require "carrierwave/orm/activerecord"

CarrierWave.configure do |config|
  config.cache_storage = :file
end
