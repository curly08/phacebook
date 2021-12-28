class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, except: :index

  def index
    @users = User.all
  end

  def edit; end

  def update
    respond_to do |format|
      if @user.update(profile_params)
        format.html { redirect_to @user, notice: "Profile was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def show; end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def profile_params
    params.require(:user).permit(:name, :birthday, :bio, :color, :animal, :food)
  end
end
