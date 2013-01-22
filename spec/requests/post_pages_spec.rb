require 'spec_helper'

describe "PostPages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "post creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a post" do
        expect { click_button "Submit" }.not_to change(Post, :count)
      end

      describe "error messages" do
        before { click_button "Submit" }
        it { should have_content('error') } 
      end
    end

    describe "with valid information" do
    	before do
    		fill_in 'post_question', with: "Lorem ipsum"
    		fill_in 'post_answer', with: "whatever"
    		fill_in	'post_grade', with: "5"
    	end
         
   	
      it "should create a post" do
        expect { click_button "Submit" }.to change(Post, :count).by(1)
      end
    end
  end
end
