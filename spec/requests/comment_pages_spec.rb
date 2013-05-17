require 'spec_helper'

describe "CommentPages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }
  let(:post) { FactoryGirl.create(:post, user: user) }
  let (:comment) { FactoryGirl.create(:comment, commenter: user, 
  		commented_post: post) }

  describe "comment creation" do
    before { visit new_post_comment_path(post) }

    describe "with invalid information" do
      it "should not create a comment" do
        expect { click_button "Submit Comment" }.not_to change(Comment, :count)
      end

      describe "error messages" do
        before { click_button "Submit Comment" }
        it { should have_content('error') } 
      end
    end

    describe "with valid information" do
    	before do
    		fill_in 'comment_content', with: "Lorem ipsum"
    	end
         
	    it "should create a comment" do
	       expect { click_button "Submit Comment" }.to change(Comment, :count).by(1)
	    end
    end
  end

  describe "comment destruction" do
    before { FactoryGirl.create(:comment, commenter: user, commented_post: post) }

    describe "as correct user" do
      before { visit new_post_comment_path(post)}

      it "should delete a comment" do
        expect { click_link 'Delete comment' }.to change(Comment, :count).by(-1)
      end
    end
  end
end
