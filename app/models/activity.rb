class Activity < ApplicationRecord
  belongs_to :activitiable, polymorphic: true
  belongs_to :project

  def comment?
    activitiable_type == 'Comment'
  end
end
