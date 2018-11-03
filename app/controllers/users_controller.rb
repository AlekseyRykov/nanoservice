class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    respond_to do |format|
      @user.update(user_params)
      format.html { redirect_to articles_url, notice: 'Verification was successfully changed.' }
    end
  end

  private

  def user_params
    params.require(:user).permit(:verification)
  end

end
