class Comment < ActiveRecord::Base
  belongs_to :chef
  belongs_to :recipe
  validates :comment, presence: true, length: { minimum: 20, maximum: 500 }
  default_scope -> { order(updated_at: :desc) }
end
