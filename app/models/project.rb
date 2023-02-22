class Project < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :activities, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :status_changes, dependent: :destroy

  enum :status, {
    created: STATUS_CREATED,
    approved: STATUS_APPROVED,
    in_progress: STATUS_IN_PROGRESS,
    completed: STATUS_COMPLETED,
  }

  validates :name, presence: true

  def change_status!(user, status)
    self.class.transaction do
      update!(status: status)
      status_changes.create!(status: status, user: user)
    end
  end
end
