require 'spec_helper'

describe "CommentPages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }
  let(:authorizer) { FactoryGirl.create(:user)}
  let(:post) { FactoryGirl.create(:post, user: user) }

  describe "whe user does not have authorization" do
    before do
      visit new_post_comment_path(post)
      click_button "Submit Comment"
    end  
   
    it "should not be able to create any comment" do
      page.should have_content("Sorry")
      user.comments.count.should == 0
    end
  end

  describe "when user has authorization" do
    before {user.authorizations.create!(authorizer_id: authorizer.id, 
        approval: "accepted")}

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
end
