class ApplicationController < ActionController::Base
  # nice concerns 👍
  include Devisable, Punditable, Trackable
end
