
class UsersController < ApplicationController
  before_action :set_people, only: %i[ dashboard ]

  def dashboard
    @q = Memory.ransack(params[:q])
    # @q.sorts = ['date desc', 'location asc'] if @q.sorts.empty?
    @q.sorts = ['date desc'] if @q.sorts.empty?
    @memories = @q.result
    @memory = Memory.new
    @memory.build_address
    @person = Person.new
  end

  private
    def set_people
      @people = Person.all
    end

    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
end
