class StatusChange < ApplicationRecord
  include Acvititiable
  belongs_to :user
  belongs_to :project

  enum :status, {
    created: STATUS_CREATED,
    approved: STATUS_APPROVED,
    in_progress: STATUS_IN_PROGRESS,
    completed: STATUS_COMPLETED
  }
end
