class Place::Crawler < ApplicationService
  attr_reader :keyword, :lat, :lng
  private :keyword, :lat, :lng

  API_KEY = Rails.application.credentials.dig(
    :google, :credentials, :map)
  ENDPOINT = "https://maps.googleapis.com".freeze

  def initialize(keyword, lat:, lng:)
    @keyword = keyword
    @lat = lat
    @lng = lng
  end

  def call
    crawled_places.each do |place_data|
      coordinates = place_data["geometry"]["location"]
      lat, lng = coordinates["lat"], coordinates["lng"]

      # possible N+1, would you find a way to fix it?
      next if exists?("en", lng, lat)

      Place.create(
        name: place_data["name"],
        coordinate: geo.point(lng, lat),
        locale: "en",
        place_type: place_type(place_data["types"])
      )
    end
  rescue Faraday::ConnectionFailed => e
    # actually, we should report this error
    # to a centralized error notification service
    puts e.message
  end

  private

    def connection
      @connection ||= Faraday.new(
        ENDPOINT,
        request: {
          timeout: 7.seconds
        }
      )
    end

    def crawled_places
      @crawled_places ||= begin
        response = connection.get do |req|
          req.url "/maps/api/place/textsearch/json"
          req.params["query"] = keyword
          req.params["radius"] = 2000
          req.params["language"] = "en"
          req.params["location"] = "#{lat},#{lng}"
          req.params["key"] = API_KEY
        end

        response = JSON.parse(response.body)
        response["results"]
      end
    end

    def place_type(google_types)
      types = Place::PLACE_TYPES.dup
      intersect = google_types & types
      intersect.first || "other"
    end

    def geo
      @geo ||= RGeo::Geographic::Factory.new(
        "Spherical",
        has_z_coordinate: true,
        srid: 4326,
      )
    end

    def exists?(locale, lng, lat)
      point = geo.point(lng, lat)

      place = Place.where(
        coordinate: point,
        locale: "en",
      ).exists?
    end

end
