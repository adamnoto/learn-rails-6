# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string           not null
#  is_public              :boolean          default("true"), not null
#  last_name              :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  username               :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#
FactoryBot.define do
  factory :user do
    username { SecureRandom.hex(3) }
    first_name { ["Adam", "Sam", "Mike"].sample }
    last_name { ["Soesanto", "Yamashita", "de Flaire"].sample }
    email { "#{SecureRandom.hex(4)}@example.org" }
    is_public { true }
    password { "MyPwd123" }

    trait :private do
      is_public { false }
    end

    transient do
      followers { [] }
    end

    after(:create) do |user, evaluator|
      evaluator.followers.each do |follower|
        create(:bond, :following, user: follower, friend: user)
      end
    end
  end
end
