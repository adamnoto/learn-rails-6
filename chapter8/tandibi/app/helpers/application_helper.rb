module ApplicationHelper
  def google_map_api_url
    credentials = Rails.application.credentials
    key = credentials.dig(:google, :credentials, :map)

    "https://maps.googleapis.com/maps/api/js?key=" + key
  end

  def visited_user
    @visited_user ||= begin
      username = params.fetch(:username)
      User.find_by_username!(username)
    end
  end
end
