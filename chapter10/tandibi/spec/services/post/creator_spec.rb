require "rails_helper"

describe Post::Creator do
  let(:user) { create(:user) }
  let(:permitted_params) { {} }

  subject { described_class.new(user, permitted_params) }

  describe "#call" do
    it "does not create when data is invalid" do
      expect(subject.call).to be_falsey
    end

    context "when creating a status" do
      let(:permitted_params) { {
        postable_type: "Status",
        status_text: "Howdy!",
      } }

      it "can post successfully" do
        expect {
          subject.call
        }.to change {
          user.posts.reload.count
        }.from(0).to(1)

        post = user.posts.first
        expect(post.postable).to be_a Status
        expect(post.postable.text).to eq "Howdy!"
      end

      it "cannot post if the text is blank" do
        permitted_params[:status_text] = ""
        expect(subject.call).to be_falsey
        expect(user.posts.count).to be_zero
      end

      context "when the user is not known" do
        let(:user) { nil }

        it "cannot post" do
          expect(subject.call).to be_falsey
        end
      end
    end
  end
end
