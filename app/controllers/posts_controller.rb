class PostsController < ApplicationController

  def create
    post = Post.new(post_params)
    if user_signed_in?
      post.user = current_user
    end

    respond_to do |format|
      if post.save
        #@updated_posts = Post.posted.limit(100).order("created_at DESC")

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
          render 'form_alert'
        }
      end
      save_number_of_posts
    end
  end

  def counter
    #n_posts = Post.posted.count
    #render partial: 'counter', locals: { number: n_posts }
    navbar_counter
    render partial: 'shared/navbar/happy_meter'
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
    save_number_of_posts
    render partial: @posts
  end

  def index
    @post = Post.new
    @posts = Post.posted.limit(100).order("created_at DESC")
    @number = Post.posted.count

    navbar_counter

    save_number_of_posts
    @post_modal = false
    if session.delete(:modal) == true
      @post_modal = true
    end

  end

  def new_posts
    n_new_posts = Post.posted.count - session[:last_post]
    render partial: 'shared/navbar/new_posts', locals: { new: n_new_posts }
  end

  def show
    @show = true
    @number = Post.posted.count

    save_number_of_posts

    navbar_counter
    @post = Post.posted.find(params[:id])

    @comments = Comment.all.where(post_id: params[:id])
    @comment = Comment.new
  end

  private

  def post_params
    params.require(:post).permit(:content,:mood_id)
  end

  def save_number_of_posts
    session[:last_post] = Post.posted.count
  end

  def navbar_counter
    @happy_meter = Post.posted.average(:mood_id)

    posts = Post.posted.count * 2
    comments = Comment.posted.count * 2
    @total_cents = (posts + comments) * 0.01
  end
end
