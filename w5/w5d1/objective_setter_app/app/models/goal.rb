class Goal < ActiveRecord::Base
  include Commentable
  
  GOAL_TYPES = ["public", "private"]
  validates :title, :goal_type, :user_id, presence: true
  validates :goal_type, inclusion: { in: GOAL_TYPES}

  belongs_to :user

  def complete!
    self.toggle!(:completed)
  end
end
