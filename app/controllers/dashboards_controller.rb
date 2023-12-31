
class DashboardsController < ApplicationController
  before_action :set_people, only: %i[ show search ]
  before_action :set_memories, only: %i[ show search ]
  before_action { authorize :dashboard, :show? }

  def show
    @memory = Memory.new # for nested form
    @person = Person.new # for nested form
    @geojson = Memory.to_geojson(@memories)
  end

  private

  def set_memories
    @memories = current_user.memories.all
  end
  
  def set_people
    @people = current_user.people.all
  end
end
