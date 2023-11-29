class MediumPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def destroy?
    owner?
  end

  private

  def owner?
    record.mediumable.author == user
  end
end
