# == Schema Information
#
# Table name: comments
#
#  id                 :integer          not null, primary key
#  comment            :text
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#  commenter_id       :integer
#  commented_post_id  :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'spec_helper'

describe Comment do
  pending "add some examples to (or delete) #{__FILE__}"
end
