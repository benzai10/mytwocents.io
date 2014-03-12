class PostsController < ApplicationController

  def create
    #if user_signed_in?
      post = Post.new(post_params)
      if post.save!
        @updated_posts = Post.posted.limit(100).order("created_at DESC")
        respond_to do |format|
          format.html { redirect_to root_path }
          format.js { }
        end
        session[:last_post] = Post.posted.count
      else
      #fail stuff here
      end
    #end
  end

  def counter
    n_posts = Post.posted.count
    render partial: 'counter', locals: { number: n_posts }
  end

  def destroy
    if current_user.admin = true
      post = Post.find(params[:id])
      post.deleted = true
      post.save
    end
    redirect_to root_path
  end

  def feed
    @posts = Post.posted.limit(100).order("created_at DESC")
    session[:last_post] = Post.posted.count
    render partial: @posts
  end

  def index
    @post = Post.new
    @posts = Post.posted.limit(100).order("created_at DESC")
    @number = Post.posted.count
    session[:last_post] = Post.posted.count
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
    n_new_posts = Post.posted.count - session[:last_post]
    render partial: 'new_posts', locals: { new: n_new_posts }
  end

  private

  def post_params
    params.require(:post).permit(:content,:id)
  end

end
