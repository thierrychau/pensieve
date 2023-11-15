class MemoriesController < ApplicationController
  before_action :set_memory, only: %i[ show edit update destroy ]
  before_action :set_people, only: %i[ create new index edit ]

  # GET /memories or /memories.json
  def index
    @q = Memory.ransack(params[:q])
    # @q.sorts = ['date desc', 'location asc'] if @q.sorts.empty?
    @q.sorts = ['date desc'] if @q.sorts.empty?
    @memories = @q.result
    @person = Person.new
    @memory = Memory.new
  end
  
  # GET /memories/1 or /memories/1.json
  def show
  end
  
  # GET /memories/new
  def new
    @memory = Memory.new
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
        people_ids = params.fetch("people")
        @memory.update_people(people_ids)

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

    respond_to do |format|
      if @memory.update(memory_params)
        people_ids = params.fetch("people")
        @memory.update_people(people_ids)

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
      format.html { redirect_to memories_url, notice: "Memory was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_memory
      @memory = Memory.find(params[:id])
    end

    def set_people
      @people = Person.all
    end

    # Only allow a list of trusted parameters through.
    def memory_params
      params.require(:memory).permit(:date, :location, :latitude, :longitude, :description)
    end
end
