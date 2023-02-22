class ProjectPolicy < ApplicationPolicy
  def create?
    user.has_role?(:admin)
  end

  def new?
    create?
  end

  def edit?
    create?
  end

  def update?
    create?
  end

  def destroy?
    create?
  end

  def index?
    true
  end

  def show?
    index?
  end

  def change_status?
    user.has_any_role?(:admin, :moderator)
  end
end
