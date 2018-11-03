class SlacksController < ApplicationController
  before_action :set_slack, only: [:show]

  # GET /slacks
  # GET /slacks.json
  def index
    @slacks = Slack.all
  end

  # GET /slacks/1
  # GET /slacks/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_slack
      @slack = Slack.find(params[:id])
    end
end
