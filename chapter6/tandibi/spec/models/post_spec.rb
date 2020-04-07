# == Schema Information
#
# Table name: posts
#
#  id            :bigint           not null, primary key
#  postable_type :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  postable_id   :bigint           not null
#  thread_id     :bigint
#  user_id       :bigint
#
# Indexes
#
#  index_posts_on_postable_type_and_postable_id  (postable_type,postable_id)
#
# Foreign Keys
#
#  fk_rails_...  (thread_id => posts.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "#save" do
    it "belongs to a user" do
      user = create(:user)

      post = Post.new(
        postable: Status.new(text: "Whohoo!"),
      )

      post.save
      expect(post).not_to be_persisted

      post.user = user
      post.save
      expect(post).to be_persisted
    end

    it "can belongs to another post" do
      user = create(:user)

      post = Post.new(
        postable: Status.new(text: "Oops!"),
        user: user,
      )

      post.save
      expect(post).to be_persisted

      reply_post = Post.new(
        postable: Status.new(text: "I forgot something"),
        user: user,
        thread: post
      )

      reply_post.save
      expect(reply_post).to be_persisted
    end
  end
end
