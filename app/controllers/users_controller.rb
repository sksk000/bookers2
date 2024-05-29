class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    unless current_user.id == @user.id
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      flash[:user_edit_error] = @user.errors.full_messages
      render "edit"
    end
  end

  def index
    @user = User.all;
  end


  def user_params
    params.require(:user).permit(:name, :introduction, :image)
  end
end
