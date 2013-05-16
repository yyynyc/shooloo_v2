require 'spec_helper'

describe Comment do
  let (:user) {FactoryGirl.create(:user)}
  let (:post) {FactoryGirl.create(:post)}
  before do 
  	@comment = user.comments.build(content: "Lorem ipsum", 
  			photo: File.new(Rails.root + 'spec/support/math.jpg'))
  	@comment.commented_post = post
  end

  subject { @comment }

  it {should respond_to(:commenter_id, :commented_post_id, 
  						:content, :photo, 
  						:visible, :likes_count)}
  its(:commenter) { should == user}
  its(:commented_post) {should == post}
  it {should be_valid}

  describe "accessible attributes" do
    it "should not allow access to commenter_id" do
      expect do
        Comment.new(commenter_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end   

    it "should not allow access to commented_post_id" do
      expect do
        Comment.new(commenteed_post_id: post.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end   

    it "should not allow access to visible" do
      expect do
        Comment.new(visible: true)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end       
  end

  describe "when commenter_id is not present" do
    before { @comment.commenter_id = nil }
    it { should_not be_valid }
  end

  describe "when commented_post_id is not present" do
    before { @comment.commented_post_id = nil }
    it { should_not be_valid }
  end

  describe "when visible is not present" do
    before { @comment.visible = nil }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { @comment.content = " " }
    it { should_not be_valid }
  end
end
