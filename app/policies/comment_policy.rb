class CommentPolicy < ApplicationPolicy
  def create?
    true
  end

  def destroy?
    user.has_role?(:admin)
  end
end
