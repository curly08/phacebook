class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(friend_id: params[:user][:friend_id])

    if @friendship.save
      redirect_to users_path
    else
      return
    end
  end

  def destroy
    @friendship = current_user.friendships.find(params[:id])

    if @friendship.destroy
      redirect_to users_path
    else
      return
    end
  end
end
