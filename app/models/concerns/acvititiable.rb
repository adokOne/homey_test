module Acvititiable
  extend ActiveSupport::Concern

  included do
    has_one :activity, as: :activitiable, dependent: :destroy
    after_create :populate_activity_entry!
  end

  private

  def populate_activity_entry!
    build_activity.update!(project:) if should_populate_activity?
  end

  def should_populate_activity?
    true
  end
end
