class PostsController < ApplicationController

  def create
    post = Post.new(post_params)
    if post.save!
      @updated_posts = Post.limit(10).order("created_at DESC")
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js { }
      end
      session[:last_post] = post.id
    else
    #fail stuff here
    end
  end

  def index
    @post = Post.new
    @posts = Post.limit(100).order("created_at DESC")
    @number = Post.all.count
    session[:last_post] = Post.last.id
  end

  def refresh
    n_posts = Post.all.count
    n_new_posts = Post.last.id - session[:last_post]
    render partial: 'counter', locals: { number: n_posts, new: n_new_posts }
  end

  def feed
    @posts = Post.limit(100).order("created_at DESC")
    session[:last_post] = @posts.first.id
    render partial: @posts
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

end
