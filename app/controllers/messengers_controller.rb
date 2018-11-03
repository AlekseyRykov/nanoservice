class MessengersController < ApplicationController

  def index
    @hipchat = Hipchat.all
    @slack = Slack.all
    @telegram = Telegram.all
  end

end