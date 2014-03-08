class PostsController < ApplicationController

  def create
    post = Post.new(post_params)
    if post.save!
      @updated_posts = Post.limit(10).order("created_at DESC")
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js { }
        end
    else
    #fail stuff here
    end
  end

  def index
    @post = Post.new
    @posts = Post.limit(100).order("created_at DESC")
  end

  def refresh
    @posts = Post.limit(100).order("created_at DESC")
    render @posts
  end


  private

  def post_params
    params.require(:post).permit(:content)
  end

end
