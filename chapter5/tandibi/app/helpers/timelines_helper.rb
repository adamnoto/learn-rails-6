module TimelinesHelper
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

  def humanized_activity_type(sight)
    case sight.activity_type
    when Sight::CHECKIN then "checked in at"
    when Sight::CHECKOUT then "checked out from"
    end
  end
end
