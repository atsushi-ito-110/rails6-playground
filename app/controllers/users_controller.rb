class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(current_user.id)
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      redirect_to edit_user_path(@user), flash: { success: '更新に成功しました' }
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, images: [])
  end
end
