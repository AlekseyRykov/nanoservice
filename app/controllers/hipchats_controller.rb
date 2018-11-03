class HipchatsController < ApplicationController
  before_action :set_hipchat, only: [:show]

  # GET /hipchats
  # GET /hipchats.json
  def index
    @hipchats = Hipchat.all
  end

  # GET /hipchats/1
  # GET /hipchats/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hipchat
      @hipchat = Hipchat.find(params[:id])
    end
end
