require 'spec_helper'

describe "#update_post" do
  it "calls `update_rank` on post" do
    post = create(:post)
    post.should respond_to(:update_rank)
    post.should_receive(:update_rank)
    Vote.create(value: 1, post: post)
  end
end