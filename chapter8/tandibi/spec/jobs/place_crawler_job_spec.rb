require 'rails_helper'

describe PlaceCrawlerJob, type: :job do
  describe "#perform" do
    it "calls the crawler service" do
      perform_enqueued_jobs do
        expect(Place::Crawler).to receive(:call)
          .with("Central Park", lat: 1, lng: 2)

        described_class.perform_later("Central Park",
          lat: 1, lng: 2)
      end
    end
  end
end
