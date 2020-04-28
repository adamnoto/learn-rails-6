# frozen_string_literal: true

class UserRules < Bali::Rules
  can :see_timeline do |user, current_user|
    user.is_public? ||
      user == current_user ||
      user.followers.include?(current_user)
  end
end
