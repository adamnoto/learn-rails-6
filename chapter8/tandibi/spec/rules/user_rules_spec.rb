# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserRules do
  let(:admin) { create(:user, :private, username: "tandibi") }
  let(:user1) { create(:user) }
  let(:user2) { create(:user, :private, followers: [user1]) }

  describe "can see_timeline?" do
    it "is possible if public profile" do
      expect(user2).to be_able_to :see_timeline, user1
    end

    context "when private profile" do
      it "is not possible" do
        expect(user1).not_to be_able_to :see_timeline, admin
        expect(user2).not_to be_able_to :see_timeline, admin
      end

      it "is possible if the viewer is a follower" do
        expect(user1).to be_able_to :see_timeline, user2
      end

      it "is possible if the viewer is an admin" do
        expect(admin).to be_able_to :see_timeline, user1
        expect(admin).to be_able_to :see_timeline, user2
      end

      it "is possible if seeing their own profile" do
        expect(admin).to be_able_to :see_timeline, admin
        expect(user1).to be_able_to :see_timeline, user1
        expect(user2).to be_able_to :see_timeline, user2
      end
    end
  end
end
