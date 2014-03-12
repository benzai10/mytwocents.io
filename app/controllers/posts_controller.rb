class PostsController < ApplicationController

  def create
    #if user_signed_in?
      post = Post.new(post_params)
      if post.save!
        @updated_posts = Post.limit(100).order("created_at DESC")
        respond_to do |format|
          format.html { redirect_to root_path }
          format.js { }
        end
        session[:last_post] = Post.all.count
      else
      #fail stuff here
      end
    #end
  end

  def counter
    n_posts = Post.all.count
    render partial: 'counter', locals: { number: n_posts }
  end

  def feed
    @posts = Post.limit(100).order("created_at DESC")
    session[:last_post] = Post.all.count
    render partial: @posts
  end

  def index
    @post = Post.new
    @posts = Post.limit(100).order("created_at DESC")
    @number = Post.all.count
    session[:last_post] = Post.all.count
    @modal = false
    if session.delete(:modal) == true
      @modal = true
    end
  end

  def modal
    redirect_to new_user_session_path
    session[:modal] = true;
  end

  def new_posts
    n_new_posts = Post.all.count - session[:last_post]
    render partial: 'new_posts', locals: { new: n_new_posts }
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

end
