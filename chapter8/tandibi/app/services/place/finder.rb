class Place::Finder < ApplicationService
  attr_reader :keyword, :lat, :lng
  private :keyword, :lat, :lng

  DISTANCE_RADIUS_IN_METRES = 200_000

  def initialize(keyword, lat:, lng:)
    @keyword = keyword
    @lat = lat
    @lng = lng
  end

  def call
    result = sort_by_distance(search_keyword_within_radius)

    if result.empty?
      result = sort_by_distance(search_by_keyword)
    end

    result
  end

  private

    def base_point
      point = "POINT(#{lng} #{lat})"
      @base_point ||= "ST_GeographyFromText('#{point}')"
    end

    def search_by_keyword
      Place.where("name ILIKE ?", "%#{keyword}%")
    end

    def search_keyword_within_radius
      search_by_keyword
        .where("ST_DWITHIN(#{base_point}, coordinate,
          #{DISTANCE_RADIUS_IN_METRES}, true)")
    end

    def sort_by_distance(relation)
      relation.order("ST_DISTANCE(#{base_point}, coordinate)")
    end

end
