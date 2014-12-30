class Instructor < ActiveRecord::Base
  has_many(
    :courses,
    class_name: 'Course',
    foreign_key: :instructor_id,
    primary_key: :id
  )
end
