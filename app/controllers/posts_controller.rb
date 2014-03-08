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
    @number = Post.all.count
  end

  def refresh
    number_of_posts = Post.all.count
    render partial: 'counter', locals: {number: number_of_posts}
  end


  private

  def post_params
    params.require(:post).permit(:content)
  end

end
