require 'spec_helper'

describe Post do
  let(:user) { FactoryGirl.create(:user) }
  before do
    @post = user.posts.build(question: "Lorem ipsum", answer: "whatever is right", 
    	grade: "5", category: "books", photo: File.new(Rails.root + 'spec/support/math.jpg'))
  end

  subject { @post }

  it { should respond_to(:question) }
  it { should respond_to(:answer) }
  it { should respond_to(:grade) }
  it { should respond_to(:category) }
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
