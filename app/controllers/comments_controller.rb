class CommentsController < ApplicationController
  before_action :get_post
  before_action :set_comment, only: %i[destroy edit update]
  before_action :authenticate_user!

  def edit
  end

  def create
    @comment = @post.comments.build(body: comment_params[:body], user_id: current_user.id)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_url(@post), notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render 'posts/show', status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to post_url(@post), notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to post_url(@post), notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def get_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
