# == Schema Information
#
# Table name: sights
#
#  id            :bigint           not null, primary key
#  activity_type :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  place_id      :bigint           not null
#
# Indexes
#
#  index_sights_on_place_id  (place_id)
#
# Foreign Keys
#
#  fk_rails_...  (place_id => places.id)
#
require 'rails_helper'

RSpec.describe Sight, type: :model do
  describe "#valid?" do
    it "should validate activity type correctly" do
      sight = build(:sight)

      sight.activity_type = "unknown"
      expect(sight).not_to be_valid

      ["checkin", "checkout"].each do |type|
        sight.activity_type = type
        expect(sight).to be_valid
      end
    end
  end
end
