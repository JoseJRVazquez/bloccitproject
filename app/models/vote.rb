class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  #validates the vote, and will reject non-matching votes, but god knows how that happens
  validates :value, inclusion: { in: [-1, 1], message: "%{value} is not a valid vote." }
end

