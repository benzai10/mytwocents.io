class CommentsController < ApplicationController

  def create
    comment = Comment.new(comment_params)
    if user_signed_in?
      comment.user = current_user
    end


    respond_to do |format|
      if comment.save

        format.html { 
          redirect_to post_path(comment_params[:post_id])
        }
        format.js {
        @comments = Comment.where(post_id: comment_params[:post_id])
        @update_post = Post.find(comment_params[:post_id]).get_cents
        }
      else

        if comment.errors.messages[:content]
          @error = "comment can not be blank."
        elsif comment.errors.messages[:mood_id]
          @error = "Please chose a mood."
        end

        format.html {
          flash[:alert] = @error
          redirect_to post_path(comment_params[:post_id])
        }
        format.js {
          render 'posts/form_alert'
        }
      end
      session[:last_post] = Post.posted.count
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content,:mood_id, :post_id)
  end

end
