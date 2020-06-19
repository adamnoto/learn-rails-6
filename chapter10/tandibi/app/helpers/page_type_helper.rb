module PageTypeHelper
  def on_timeline?
    controller_path == "timelines"
  end

  def on_bunch?
    on_timeline? && action_name == "index"
  end

  def on_self?
    on_timeline? && action_name == "show" &&
      params[:username] == current_user.username
  end

  def on_settings?
    controller_path.start_with? "settings"
  end

  def on_following_list?
    controller_path == "bonds" &&
      action_name == "following"
  end

  def on_follower_list?
    controller_path == "bonds" &&
      action_name == "followers"
  end
end
