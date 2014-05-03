class VotesController < ApplicationController
  before_filter :setup #sets up for both up and down votes keeping code DRY

  def up_vote
    update_vote(1)
    redirect_to :back
  end

  def down_vote
    update_vote(-1)
    redirect_to :back
  end

  private #this keeps the setup outside of other classes and restricts it only to voting

  def setup
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])

    @vote = @post.votes.where(user_id: current_user.id).first
  end

  def update_vote(new_value)
    if @vote # if there is a vote, update the vote
      authorize @vote, :update? #makes it so you have to be a member of this site to vote
      @vote.update_attribute(:value, new_value)
    else # if there is no vote, create a new vote
      @vote = current_user.votes.create(value: new_value, post: @post)
      authorize @vote, :create?
      @vote.save #I assume this saves the new vote
    end
  end
end