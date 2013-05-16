require 'spec_helper'

describe Post do
  let(:user) { FactoryGirl.create(:user) }
  before do
    @post = user.posts.build(question: "Lorem ipsum", answer: "whatever is right", 
    	grade: "5th grade", category: "books", photo: File.new(Rails.root + 'spec/support/math.jpg'))
  end

  subject { @post }

  it { should respond_to(:question, :answer, :grade, :category, :photo, :user) }
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

  describe "comment associations" do
    before { @post.save }
    let(:commenter1) { FactoryGirl.create(:user) }
    let(:commenter2) { FactoryGirl.create(:user) }
    let!(:older_comment) do 
      FactoryGirl.create(:comment, commenter: commenter1, 
        commented_post: @post, created_at: 1.day.ago)
    end
    let!(:newer_comment) do
      FactoryGirl.create(:comment, commenter: commenter2,
        commented_post: @post, created_at: 1.hour.ago)
    end

    it "should have the right comments in the right order" do
      @post.comments.should == [newer_comment, older_comment]
    end

    it "should destroy associated comment" do
      comments = @post.comments.dup
      @post.destroy
      comments.should_not be_empty
      comments.each do |comment|
        Comment.find_by_id(comment.id).should be_nil
      end
    end
  end
end
