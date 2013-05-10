require 'spec_helper'

describe "PostPages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

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
      before { visit root_path }

      it "should delete a post" do
        expect { click_link 'Delete Post' }.to change(Post, :count).by(-1)
      end
    end
  end
end
