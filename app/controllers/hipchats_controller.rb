class HipchatsController < ApplicationController
  before_action :set_hipchat, only: [:show, :edit, :update, :destroy]

  # GET /hipchats
  # GET /hipchats.json
  def index
    @hipchats = Hipchat.all
  end

  # GET /hipchats/1
  # GET /hipchats/1.json
  def show
  end

  # GET /hipchats/new
  def new
    @hipchat = Hipchat.new
  end

  # GET /hipchats/1/edit
  def edit
  end

  # POST /hipchats
  # POST /hipchats.json
  def create
    @hipchat = Hipchat.new(hipchat_params)

    respond_to do |format|
      if @hipchat.save
        format.html { redirect_to @hipchat, notice: 'Hipchat was successfully created.' }
        format.json { render :show, status: :created, location: @hipchat }
      else
        format.html { render :new }
        format.json { render json: @hipchat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hipchats/1
  # PATCH/PUT /hipchats/1.json
  def update
    respond_to do |format|
      if @hipchat.update(hipchat_params)
        format.html { redirect_to @hipchat, notice: 'Hipchat was successfully updated.' }
        format.json { render :show, status: :ok, location: @hipchat }
      else
        format.html { render :edit }
        format.json { render json: @hipchat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hipchats/1
  # DELETE /hipchats/1.json
  def destroy
    @hipchat.destroy
    respond_to do |format|
      format.html { redirect_to hipchats_url, notice: 'Hipchat was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hipchat
      @hipchat = Hipchat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hipchat_params
      params.require(:hipchat).permit(:title, :description, :author, :article_id)
    end
end
