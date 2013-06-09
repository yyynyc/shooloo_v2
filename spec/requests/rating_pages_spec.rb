require 'spec_helper'

describe "RatingPages" do
	subject { page }

	let(:user) { FactoryGirl.create(:user) }
	let(:poster) { FactoryGirl.create(:user) }
	let(:referrer) { FactoryGirl.create(:user) }
	let(:post) { FactoryGirl.create(:post, user: poster) }
	9.times do
		FactoryGirl.create(:operation)
	end
	let(:rating) { FactoryGirl.create(:rating, rater: user, 
	  		rated_post: post) }

	before { sign_in user }
		
	describe "user who does not have referral" do
	   	before do
	   	 visit new_post_rating_path(post)
	   	 click_button "Create Rating" 
	   	end
	   
	    it "should not be able to create any rating" do
	      page.should have_content("Sorry")
	      user.ratings.count.should == 0
	    end
	end 

  	describe "user who has referral" do
    	before {user.referrals.create!(referrer_id: referrer.id, 
        approval: "accepted")} 

	  	describe "rating creation" do
	    	before { visit new_post_rating_path(post) }

		    describe "with invalid information" do
		      it "should not create a rating" do
			  	expect { click_button "Create Rating" }.not_to change(Rating, :count)
		      end

		      describe "error messages" do
		        before { click_button "Create Rating" }
		        it { should have_content('error') } 
		      end
		    end

		    describe "with valid information" do
		    	before do
		    		select "Right", from: 'rating_answer_correctness'
		    		select "No, it is BELOW grade", from: 'rating_grade_suitability'
		    		select "1 step", from: 'rating_steps'
		    		check("operation #1")
		    		choose("Excellent work!")
		    	end
		         
			    it "should create a rating" do
			       expect {
			       	click_button "Create Rating"
			       }.to(change(Rating, :count).by(1))
			    end
		    end
		end

		describe "rating destruction" do
			before { FactoryGirl.create(:rating, rater: user, rated_post: post) }

		    describe "as correct user" do
		    	before { visit rated_posts_user_path(user)}

		    	it "should delete a rating" do
		        	expect { click_link 'Delete Rating' }.to change(Rating, :count).by(-1)
		      	end
		    end
		end

		describe "rating update" do
			before { FactoryGirl.create(:rating, rater: user, rated_post: post) }

		    describe "as correct user" do
		    	before { visit edit_post_rating_path(post, rating)}

		    	describe "with invalid information" do
		    		before do 
		    			select "", from: 'rating_answer_correctness'
		    			click_button "Update Rating"
		    		end
			         it { should have_content('error') }		     
			    end
			end
		end
	end
end
