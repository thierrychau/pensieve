class MediaController < ApplicationController
  before_action :set_medium, only: %i[ destroy ]
  before_action { authorize (@medium || Medium) }

  def destroy
    @medium.destroy

    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path, notice: "Medium was successfully destroyed.") }
      format.json { head :no_content }
    end
  end

  private
  
  def set_medium
    @medium = Medium.find(params[:id])
  end
end
