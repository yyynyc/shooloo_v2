# == Schema Information
#
# Table name: ratings
#
#  id                 :integer          not null, primary key
#  rater_id           :string(255)
#  rated_post_id      :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  answer_correctness :integer
#  steps              :integer
#  grade_suitability  :integer
#  overall_rating     :boolean
#

require 'spec_helper'

describe Rating do
  pending "add some examples to (or delete) #{__FILE__}"
end
