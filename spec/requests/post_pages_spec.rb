require 'spec_helper'

describe "PostPages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  let(:authorizer) { FactoryGirl.create(:user)}
  before { sign_in user }

  describe "whe user does not have authorization" do
    before do
        visit root_path
        fill_in 'post_question', with: "Lorem ipsum"
        fill_in 'post_answer', with: "whatever"
        select  "5th grade", from: 'post_grade'
        select "books", from: 'post_category'
        attach_file 'post_photo', Rails.root.join('spec', 'support', 'math.jpg')
        click_button "Save"
      end

    it "should not be able to create any post" do
      page.should have_content("You don't have pemission to do this. Get referrals or authorization first.")
      user.posts.count.should == 0
    end
  end

  describe "when user has authorization" do
    before {user.authorizations.create!(authorizer_id: authorizer.id, 
        approval: "accepted")}

    describe "post creation" do
      before { visit root_path }

      describe "with invalid information" do

        it "should not create a post" do
          expect { click_button "Save" }.not_to change(Post, :count)
        end

        describe "error messages" do
          before { click_button "Save" }
          it { should have_content('error') } 
        end
      end

      describe "with valid information" do
      	before do
      		fill_in 'post_question', with: "Lorem ipsum"
      		fill_in 'post_answer', with: "whatever"
      		select	"5th grade", from: 'post_grade'
          select "books", from: 'post_category'
          attach_file 'post_photo', Rails.root.join('spec', 'support', 'math.jpg')
      	end
 
        it "should create a post" do
          expect { click_button "Save" }.to change(Post, :count).by(1)
        end
      end
    end

    describe "post destruction" do
      before { FactoryGirl.create(:post, user: user) }

      describe "as correct user" do
        before { visit posts_user_path(user)}

        it "should delete a post" do
          page.should have_button('Alarm')
          page.should have_link('Rating Results')
          page.should have_link('Edit Post')
          page.should have_link ('Comment')
          page.should have_link('Delete Post')
          expect { click_link 'Delete Post' }.to change(Post, :count).by(-1)
        end
      end
    end
  end
end
