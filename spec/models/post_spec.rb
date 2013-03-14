# == Schema Information
#
# Table name: posts
#
#  id                             :integer          not null, primary key
#  question                       :text
#  answer                         :string(255)
#  grade                          :string(255)
#  user_id                        :integer
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#  attachment_file_name           :string(255)
#  attachment_content_type        :string(255)
#  attachment_file_size           :integer
#  attachment_updated_at          :datetime
#  photo_file_name                :string(255)
#  photo_content_type             :string(255)
#  photo_file_size                :integer
#  photo_updated_at               :datetime
#  category                       :string(255)
#  image_host                     :string(255)
#  answer_correctness_1_count     :integer
#  answer_correctness_2_count     :integer
#  answer_correctness_3_count     :integer
#  answer_correctness_4_count     :integer
#  operation_whole_count          :integer
#  visible                        :boolean
#  ratings_count                  :integer
#  overall_true_count             :integer
#  overall_false_count            :integer
#  grade_below_count              :integer
#  grade_right_count              :integer
#  grade_above_count              :integer
#  steps_1_count                  :integer
#  steps_2_count                  :integer
#  steps_3_count                  :integer
#  steps_4_count                  :integer
#  steps_5_count                  :integer
#  steps_6_count                  :integer
#  operation_decimal_count        :integer
#  operation_fraction_count       :integer
#  operation_percentage_count     :integer
#  operation_negative_count       :integer
#  operation_addition_count       :integer
#  operation_substraction_count   :integer
#  operation_multiplication_count :integer
#  operation_division_count       :integer
#  vocabulary_count               :integer
#  grammar_count                  :integer
#  structure_count                :integer
#  clarity_count                  :integer
#  originality_count              :integer
#  plagerism_count                :integer
#  content_count                  :integer
#  image_count                    :integer
#

require 'spec_helper'

describe Post do
  let(:user) { FactoryGirl.create(:user) }
  before do
    @post = user.posts.build(question: "Lorem ipsum", answer: "whatever is right", 
    	grade: "5", photo: File.new(Rails.root + 'spec/support/math.jpg'))
  end

  subject { @post }

  it { should respond_to(:question) }
  it { should respond_to(:answer) }
  it { should respond_to(:grade) }
  it { should respond_to(:user) }
  it { should respond_to(:photo)}
  its(:user) { should == user }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Post.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end

  describe "when user_id is not present" do
    before { @post.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank question" do
    before { @post.question = " " }
    it { should_not be_valid }
  end

  describe "with blank answser" do
    before { @post.answer = " " }
    it { should_not be_valid }
  end

  describe "with blank grade" do
    before { @post.grade = " " }
    it { should_not be_valid }
  end

  describe "with answer that is too long" do
    before { @post.answer = "a" * 101 }
    it { should_not be_valid }
  end
end
