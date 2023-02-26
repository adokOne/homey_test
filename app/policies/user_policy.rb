class UserPolicy < ApplicationPolicy
  def index?
    user.has_role?(:admin)
  end

  def edit?
    index?
  end

  def update?
    user.has_role?(:admin) || record.id == user.id
  end

  def destroy?
    user.has_role?(:admin)
  end
end
