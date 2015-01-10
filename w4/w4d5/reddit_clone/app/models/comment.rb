class Comment < ActiveRecord::Base
  belongs_to :author, class_name: "User"
  belongs_to :commentable, polymorphic: true
  has_many(:child_comments,
            class_name: "Comment",
            foreign_key: :commentable_id,
            primary_key: :id,
            as: :commentable)

end
