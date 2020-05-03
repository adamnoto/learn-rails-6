class BondsController < ApplicationController
  delegate :visited_user, to: :helpers

  def follow
    unless can? :follow, visited_user
      return redirect_to timeline_path(visited_user)
    end

    bond = Bond::Follower.call(
      current_user,
      visited_user,
    )

    if bond.requesting?
      flash[:notice] = "A follow request has been sent to " +
        "@#{visited_user.username} and is pending their approval."
    end

    redirect_to timeline_path(visited_user)
  end

  def unfollow
    unless can? :unfollow, visited_user
      return redirect_to timeline_path(visited_user)
    end

    bond = Bond::Unfollower.call(
      current_user,
      visited_user,
    )

    redirect_to timeline_path(visited_user)
  end

  def accept
    Bond::Acceptor.call(visited_user, current_user)
    redirect_to timeline_path(current_user)
  end

  def reject
    Bond::Rejector.call(visited_user, current_user)
    redirect_to timeline_path(current_user)
  end

  def followers
    @bonded_users = visited_user.followers
  end

  def following
    @bonded_users = visited_user.followings
  end
end
