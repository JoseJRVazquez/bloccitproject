class CommentController < ApplicationController
  def create
    @topic = Topic.find( params[:topic_id] )
    @post = @topic.posts.find( params[:post_id] )
    @comments = @post.comments

    @comment = current_user.comments.build( comment_params )
    @comment.post = @post
    @new_comment = Comment.new

    authorize @comment

    if @comment.save
      flash[:notice] = "Comment was created."
    else
      flash[:error] = "There was an error saving the comment. Please try again."
    end

    respond_with(@comment) do |f|
      f.html { redirect_to [@topic, @post] }
    end
  end
end
