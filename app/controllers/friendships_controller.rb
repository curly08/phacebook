class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @friendship = current_user.friendships.build(friend_id: params[:user][:friend_id])

    respond_to do |format|
      if @friendship.save
        format.html { redirect_to users_url, notice: "Friendship was successfully created." }
        format.json { render :json, status: :created }
      else
        format.html { redirect_to users_url, status: :unprocessable_entity, notice: "Friendship was unsuccessfully created." }
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "Friendship was successfully destroyed." }
      format.json { head :no_content }
    end
  end
end
