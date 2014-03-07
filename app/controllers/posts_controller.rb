class PostsController < ApplicationController

  def create
    post = Post.new(post_params)
    post.save!
    redirect_to root_path
  end

  def index
    @post = Post.new
    @posts = Post.limit(100).order("created_at DESC")
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

end
