class UserPolicy < ApplicationPolicy
  def index?
    user.has_role?(:admin)
  end

  def edit?
    index?
  end

  def update?
    index? || record.id == user.id
  end

  def destroy?
    index? #&& record.id != user.id
  end
end
