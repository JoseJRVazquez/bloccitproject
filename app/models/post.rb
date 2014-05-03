class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  belongs_to :user
  belongs_to :topic
  mount_uploader :image  #, ImageUploader #add this after correcting
  has_many :votes, dependent: :destroy

  default_scope { order('created_at DESC') }

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
end
