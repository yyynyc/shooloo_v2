# == Schema Information
#
# Table name: flags
#
#  id         :integer          not null, primary key
#  name       :text
#  rating_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  position   :integer
#

require 'spec_helper'

describe Flag do
  pending "add some examples to (or delete) #{__FILE__}"
end
