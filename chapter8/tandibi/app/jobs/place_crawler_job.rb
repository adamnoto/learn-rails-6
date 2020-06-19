class PlaceCrawlerJob < ApplicationJob
  queue_as :default

  def perform(name, lat:, lng:)
    Place::Crawler.call(name, lat: lat, lng: lng)
  end
end
