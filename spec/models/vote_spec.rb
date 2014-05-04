require 'spec_helper'

  describe "#update_post" do
    it "calls `update_rank` on post" do
      Post.skip_callback(:create,:after,:create_vote)
      post = Post.new
      post.save(validate: false)
      post.should_receive(:update_rank)
      Vote.create(value: 1, post: post)
      Post.set_callback(:create, :after, :create_vote)
    end
  end