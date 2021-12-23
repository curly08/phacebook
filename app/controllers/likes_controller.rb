class LikesController < ApplicationController
  def create
    @like = current_user.likes.build(post_id: params[:like][:post_id])

    respond_to do |format|
      if @like.save
        format.html { redirect_to request.referrer, notice: "Like was successfully created." }
        format.json { render :json, status: :created }
      else
        format.html { redirect_to users_url, status: :unprocessable_entity, notice: "like was unsuccessfully created." }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    @like.destroy

    respond_to do |format|
      format.html { redirect_to request.referrer, notice: "Like was successfully destroyed." }
      format.json { head :no_content }
    end
  end
end
