require 'spec_helper'

describe Like do
	let(:user) {FactoryGirl.create(:user)}
	let(:poster) {FactoryGirl.create(:user)}
	let(:commenter) {FactoryGirl.create(:user)}
	let(:post) {FactoryGirl.create(:post, user: poster)}
	let(:comment) {FactoryGirl.create(:comment, 
	  	commenter: commenter, commented_post: post)}

	describe "like post" do
		before do 
			@like = user.likes.build
			@like.liked_post = post
			@like.save!
		end

		subject { @like }

		it {should respond_to(:liker, :liked_post, :liked_comment)}
		its(:liker) { should == user}
		its(:liked_post) {should == post}
		it {should be_valid}

		describe "accessible attributes" do
		    it "should not allow access to liker_id" do
		      expect do
		        Like.new(liker_id: user.id)
		      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
		    end    
	  	end

	  	describe "when liker_id is not present" do
			before { @like.liker_id = nil }
			it { should_not be_valid }
		end

		describe "when liked_post_id is not present" do
		    before { @like.liked_post_id = nil }
		    it { should_not be_valid }
		end   
	end

	describe "like comment" do
		before do 
			@like = user.likes.build
			@like.liked_comment = comment
		end

		subject { @like }

		it {should respond_to(:liker_id, :liked_post_id, :liked_comment_id)}
		its(:liker) { should == user}
		its(:liked_comment) {should == comment}
		it {should be_valid}

		describe "accessible attributes" do
		    it "should not allow access to liker_id" do
		      expect do
		        Like.new(liker_id: user.id)
		      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
		    end   

		    it "should not allow access to liked_comment_id" do
		      expect do
		        Comment.new(liked_comment_id: comment.id)
		      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
		    end		 
	  	end   
	end
end
