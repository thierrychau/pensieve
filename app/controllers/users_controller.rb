
class UsersController < ApplicationController
  before_action :set_people, only: %i[ dashboard search ]
  before_action :set_memories, only: %i[ dashboard search ]
  before_action { authorize current_user }

  def dashboard
    @q = @user_memories.ransack(params[:q])
    @q.sorts = ['date desc'] if @q.sorts.empty?
    @memories = @q.result
    @memory = Memory.new # for nested form
    @person = Person.new # for nested form
    @memory.build_address # for nested form
  end

  private
    def set_memories
      @user_memories = current_user.memories.all
    end
    
    def set_people
      @people = current_user.people.all
    end
end
