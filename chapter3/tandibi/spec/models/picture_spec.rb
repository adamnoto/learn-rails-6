# == Schema Information
#
# Table name: pictures
#
#  id         :bigint           not null, primary key
#  caption    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :bigint           not null
#
# Foreign Keys
#
#  fk_rails_...  (post_id => posts.id)
#
require 'rails_helper'

RSpec.describe Picture, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
