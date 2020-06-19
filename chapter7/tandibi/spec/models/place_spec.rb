# == Schema Information
#
# Table name: places
#
#  id         :bigint           not null, primary key
#  coordinate :geography        not null, point, 4326
#  locale     :string           not null
#  name       :string           not null
#  place_type :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_places_on_coordinate             (coordinate) USING gist
#  index_places_on_locale                 (locale)
#  index_places_on_locale_and_coordinate  (locale,coordinate) UNIQUE
#
require 'rails_helper'

RSpec.describe Place, type: :model do
  describe "#valid?" do
    it "should validate the type correctly" do
      place = Place.new(locale: "en", name: "Cool Restaurant")
      place.coordinate = "POINT (1 2 3)"
      place.place_type = "unknown"
      expect(place).not_to be_valid

      Place::PLACE_TYPES.each do |type|
        place.place_type = type
        expect(place).to be_valid
      end
    end
  end
end
