class Activity < ApplicationRecord
  belongs_to :activitiable, polymorphic: true
  belongs_to :project
end
