class PagesController < ApplicationController
  def landing
  end

  def panel
    if current_user.admin == true
      @total_count = Post.all.count
      @posted_count = Post.posted.count
      @deleted_posts = Post.deleted
    else
      redirect_to root_path
    end
  end

  def terms
  end
end
