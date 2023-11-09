class UsersController < ApplicationController
  def dashboard
    @memory = Memory.new
  end
end
