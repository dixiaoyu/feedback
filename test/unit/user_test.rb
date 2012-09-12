# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  user_id    :string(255)
#  pwd        :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
