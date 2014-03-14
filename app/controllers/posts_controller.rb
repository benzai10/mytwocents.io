class PostsController < ApplicationController

  def create
    post = Post.new(post_params)
    if user_signed_in?
      post.user = current_user
    end

    respond_to do |format|
      if post.save
        @updated_posts = Post.posted.limit(100).order("created_at DESC")
        session[:last_post] = Post.posted.count

        format.html { redirect_to root_path }
        format.js { }
      else

        if post.errors.messages[:content]
          @error = "Post can not be blank."
        elsif post.errors.messages[:mood_id]
          @error = "Please chose a mood."
        end

        format.html {
          flash[:alert] = @error
          session[:modal] = true
          redirect_to root_path
        }
        format.js {
          render 'alert'
        }
      end
    end
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

    @post_modal = false
    if session.delete(:modal) == true
      @post_modal = true
    end

  end

  def new_posts
    n_new_posts = Post.posted.count - session[:last_post]
    render partial: 'new_posts', locals: { new: n_new_posts }
  end

  private

  def post_params
    params.require(:post).permit(:content,:mood_id)
  end

end
