module Acvititiable
  extend ActiveSupport::Concern

  included do
    has_one :activity, as: :activitiable
    after_create :populate_activity_entry!
    after_destroy :destroy_activity_entry!
  end

  private

  def populate_activity_entry!
    build_activity.update!(project: project) if should_populate_activity?
  end

  def destroy_activity_entry!
    activity&.destroy!
  end

  def should_populate_activity?
    true
  end
end

