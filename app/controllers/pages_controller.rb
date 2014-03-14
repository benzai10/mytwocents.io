class PagesController < ApplicationController
  def landing
  end

  def panel
    if current_user.admin == true
      @post_count = Post.all.count
      @posted_count = Post.posted.count
      @deleted_posts = Post.deleted_posts
    else
      redirect_to root_path
    end
  end

  def terms
  end
end
