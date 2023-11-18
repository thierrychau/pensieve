# Load the Rails application.
require_relative "application"
# Added for image upload
require "carrierwave"
require "carrierwave/orm/activerecord"

# Initialize the Rails application.
Rails.application.initialize!
