class MemoriesController < ApplicationController
  before_action :set_memory, only: %i[ show edit update destroy ]
  before_action :set_people, only: %i[ index new edit create update ]
  before_action :new_memory, only: %i[ index new ] # for create form
  before_action :new_person, only: %i[ index ] # for nested create form
  before_action :build_address, only: %i[ index new edit ] # for nested create form
  before_action :build_media, only: %i[ index new edit ] # for nested create form
  before_action { authorize (@memory || Memory) }
  
  def index
    # if params[:person_id]
    #   @user_memories = @user_memories.joins(:people_memories).where(people_memories: { person_id: params[:person_id] })
    # end
    @q = policy_scope(Memory).ransack(params[:q])
    @q.sorts = ['date desc', 'address_input asc'] if @q.sorts.empty?
    @memories = @q.result
    authorize :dashboard, :show?
  end

  # GET /memories/1 or /memories/1.json
  def show
  end
  
  # GET /memories/new
  def new
  end
  
  # GET /memories/1/edit
  def edit
  end

  # POST /memories or /memories.json
  def create
    @memory = Memory.new(memory_params)
    @memory.author = current_user

    respond_to do |format|
      if @memory.save
        format.html { redirect_back(fallback_location: root_path, notice: "Memory was successfully created.") }
        format.json { render :show, status: :created, location: @memory }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @memory.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /memories/1 or /memories/1.json
  def update
    @memory.assign_attributes(memory_params)
    if @memory.valid?
      # Delete unchecked people_memories
      to_destroy_ids = params.fetch("memory").fetch("people_memories_attributes").values.select { |attributes| attributes.fetch("_destroy") == "1" }.map { |attributes| attributes.fetch("person_id") }
      @memory.people_memories.where({ :id => to_destroy_ids }).each(&:destroy) 
    end
    respond_to do |format|
      if @memory.save
        format.html { redirect_to memory_url(@memory), notice: "Memory was successfully updated." }
        format.json { render :show, status: :ok, location: @memory }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @memory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memories/1 or /memories/1.json
  def destroy
    @memory.destroy

    respond_to do |format|
      format.html { redirect_to root_path, notice: "Memory was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_memory
      @memory = Memory.find(params[:id])
    end
    
    def set_people
      @people = current_user.people.all
    end

    def new_memory
      @memory = Memory.new
    end

    def new_person
      @person = Person.new
    end

    def build_address
      @memory.build_address unless @memory.address
    end

    def build_media
      @memory.media.build unless @memory.media.any?
    end

    # Only allow a list of trusted parameters through.
    def memory_params
      params.require(:memory).permit(
        :title,
        :description,
        :date,
        address_attributes: [:input],
        people_memories_attributes: [:id, :person_id, :_destroy],
        media_attributes: [:url]
        )
    end
end
