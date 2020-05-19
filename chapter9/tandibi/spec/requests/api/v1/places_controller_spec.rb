require "rails_helper"

describe Api::V1::PlacesController do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe "GET /" do
    context "when the given place is not exist yet" do
      it "can give us the list after being crawled" do
        VCR.use_cassette("api_v1_places_index_central_park") do
          perform_enqueued_jobs do
            expect(Place.all).to be_blank

            get api_v1_places_path, params: {
                keyword: "Central Park",
                lat: 40.785091,
                lng: -73.968285
              }

            expect(json_response).not_to be_blank
            expect(Place.all).not_to be_blank
          end
        end
      end
    end
  end
end
