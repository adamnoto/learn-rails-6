require 'rails_helper'

RSpec.describe "timelines/_line.html.erb" do
  let(:post) { create(:post) }

  before do
    render "timelines/line", post: post
  end

  subject { Nokogiri::HTML(rendered) }

  it "can be rendered" do
    expect(subject.css(".line").count).to eq 1
    expect(subject.css(".replies")).to be_empty
    expect(subject.css(".line .identifier"))
      .not_to be_empty
  end

  context "when there are replies" do
    let(:post) { create(:post, :with_replies) }

    it "can be rendered" do
      expect(subject.css(".replies .line").count)
        .to eq post.replies.count
    end
  end
end
