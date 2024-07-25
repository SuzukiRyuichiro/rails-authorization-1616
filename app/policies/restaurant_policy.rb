class RestaurantPolicy < ApplicationPolicy
  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
  # In most cases the behavior will be identical, but if updating existing
  # code, beware of possible changes to the ancestors:
  # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.where.not(user: user)
      # Restaurant.all
    end
  end

  def show?
    # In here, we write the logic of who is able to run #show for this resource (a restaurant)
    # If it is a diary app, should be the owner
    # If it is a paid news article, maybe who are paid member
    # If it is just a restaurant info app, everyone
    return true
  end

  def new?
    return true
  end

  def create?
    new?
  end

  def edit?
    # only the owner of the restaurant can see the form
    # record refers to the instance given by the authorize method
    # user refers to the current_user
    record.user == user
  end

  def update?
    edit?
  end

  def destroy?
    # Make sure that the restaurant belongs to currently logged in user
    record.user == user
  end
end
