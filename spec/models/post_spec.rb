require 'spec_helper'

describe Post do
  let(:user) { FactoryGirl.create(:user) }
  before do
    @post = user.posts.build(question: "Lorem ipsum", answer: "whatever is right", 
    	grade: "5")
  end

  subject { @post }

  it { should respond_to(:question) }
  it { should respond_to(:answer) }
  it { should respond_to(:grade) }
  it { should respond_to(:user) }
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
end
