class MessengersController < ApplicationController
  before_action :set_messenger, only: [:show, :edit, :update, :destroy]

  # GET /messengers
  # GET /messengers.json
  def index
    @hipchat = Hipchat.all
    @slack = Slack.all
    @telegram = Telegram.all
  end

  # GET /messengers/1
  # GET /messengers/1.json
  def show
  end

  # GET /messengers/new
  def new
    @messenger = Messenger.new
  end

  # GET /messengers/1/edit
  def edit
  end

  # POST /messengers
  # POST /messengers.json
  def create
    @messenger = Messenger.new(messenger_params)

    respond_to do |format|
      if @messenger.save
        format.html { redirect_to @messenger, notice: 'Messenger was successfully created.' }
        format.json { render :show, status: :created, location: @messenger }
      else
        format.html { render :new }
        format.json { render json: @messenger.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messengers/1
  # PATCH/PUT /messengers/1.json
  def update
    respond_to do |format|
      if @messenger.update(messenger_params)
        format.html { redirect_to @messenger, notice: 'Messenger was successfully updated.' }
        format.json { render :show, status: :ok, location: @messenger }
      else
        format.html { render :edit }
        format.json { render json: @messenger.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messengers/1
  # DELETE /messengers/1.json
  def destroy
    @messenger.destroy
    respond_to do |format|
      format.html { redirect_to messengers_url, notice: 'Messenger was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_messenger
      @messenger = Messenger.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def messenger_params
      params.fetch(:messenger, {})
    end
end
