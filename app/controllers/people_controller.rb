class PeopleController < ApplicationController
  before_action :set_person, only: %i[ show edit update destroy ]
  before_action :new_person, only: %i[ index new ] # for create form
  before_action { authorize(@person || Person) }

  def index
    @people = policy_scope(Person).all
  end

  def show
    @memories = policy_scope(@person.memories).by_date
  end

  def new
  end

  def edit
  end

  def create
    @person = Person.new(person_params)
    @person.user = current_user # TO DO: create families and assign to a family

    respond_to do |format|
      if @person.save
        format.html { redirect_back(fallback_location: root_path, notice: "Person was successfully created.") }
        format.json { render :show, status: :created, location: @person }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to people_url, notice: "Person was successfully updated." }
        format.json { render :show, status: :ok, location: @person }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @person.destroy

    respond_to do |format|
      format.html { redirect_to people_url, notice: "Person was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_person
      @person = Person.find(params[:id])
    end

    def new_person
      @person = Person.new
    end

    def person_params
      params.require(:person).permit(
        :first_name, 
        :last_name, 
        :alternate_name, 
        :date_of_birth,
        :avatar)
    end
end
