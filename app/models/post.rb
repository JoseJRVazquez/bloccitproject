class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  belongs_to :user
  belongs_to :topic
  after_create :create_vote
  mount_uploader :image  #, ImageUploader #add this after correcting
  has_many :votes, dependent: :destroy

  default_scope { order('rank DESC') } #changes it to rank formula

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :topic, presence: true
  validates :user, presence: true

  def up_votes #counts up votess
    self.votes.where(value: 1).count
  end

  def down_votes #counts down votes
    self.votes.where(value: -1).count
  end

  def points #shows the points accumulated
    self.votes.sum(:value).to_i
  end

  def update_rank
    age = (self.created_at - Time.new(1970,1,1)) / 86400
    new_rank = points + age

    self.update_attribute(:rank, new_rank)
  end

  private

  # Who ever created a post, should automatically be set to "voting" it up.
  def create_vote
    user.votes.create(value: 1, post: self)
  end
end
