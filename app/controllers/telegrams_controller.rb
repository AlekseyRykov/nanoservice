class TelegramsController < ApplicationController
  before_action :set_telegram, only: [:show, :edit, :update, :destroy]

  # GET /telegrams
  # GET /telegrams.json
  def index
    @telegrams = Telegram.all
  end

  # GET /telegrams/1
  # GET /telegrams/1.json
  def show
  end

  # GET /telegrams/new
  def new
    @telegram = Telegram.new
  end

  # GET /telegrams/1/edit
  def edit
  end

  # POST /telegrams
  # POST /telegrams.json
  def create
    @telegram = Telegram.new(telegram_params)

    respond_to do |format|
      if @telegram.save
        format.html { redirect_to @telegram, notice: 'Telegram was successfully created.' }
        format.json { render :show, status: :created, location: @telegram }
      else
        format.html { render :new }
        format.json { render json: @telegram.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /telegrams/1
  # PATCH/PUT /telegrams/1.json
  def update
    respond_to do |format|
      if @telegram.update(telegram_params)
        format.html { redirect_to @telegram, notice: 'Telegram was successfully updated.' }
        format.json { render :show, status: :ok, location: @telegram }
      else
        format.html { render :edit }
        format.json { render json: @telegram.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /telegrams/1
  # DELETE /telegrams/1.json
  def destroy
    @telegram.destroy
    respond_to do |format|
      format.html { redirect_to telegrams_url, notice: 'Telegram was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_telegram
      @telegram = Telegram.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def telegram_params
      params.require(:telegram).permit(:title, :description, :author, :article_id)
    end
end
