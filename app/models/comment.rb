class Comment < ApplicationRecord
  include Acvititiable
  belongs_to :user
  belongs_to :project
  belongs_to :comment, optional: true
  has_many :comments, dependent: :destroy

  validates :text, presence: true

  private

  def should_populate_activity?
    comment.nil?
  end
end
