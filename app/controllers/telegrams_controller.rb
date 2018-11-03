class TelegramsController < ApplicationController
  before_action :set_telegram, only: [:show]

  # GET /telegrams
  # GET /telegrams.json
  def index
    @telegrams = Telegram.all
  end

  # GET /telegrams/1
  # GET /telegrams/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_telegram
      @telegram = Telegram.find(params[:id])
    end
end
