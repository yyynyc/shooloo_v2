# == Schema Information
#
# Table name: ratings
#
#  id            :integer          not null, primary key
#  rater_id      :string(255)
#  rated_post_id :string(255)
#  value         :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'spec_helper'

describe Rating do
  pending "add some examples to (or delete) #{__FILE__}"
end
