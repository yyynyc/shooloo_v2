require 'spec_helper'

describe "AuthorizationPages" do
  describe Authorization do
  	subject { page }

  	let(:user) {FactoryGirl.create(:user)}
  	let(:poster) {FactoryGirl.create(:user)}
  	let(:post) {FactoryGirl.create(:post, user: poster)}
  	before do 
  		user.save!
  		poster.save!
  		post.save!
    	referrer = User.create!(screen_name: "Enchanted_Collar",
			first_name: "Robin", last_name: "Yang", 
			password: "shooloo", password_confirmation: "shooloo",
			privacy: true, rules: true, role: "teacher")
    	referrer.authorizations.create!(authorizer_id: poster.id, approval: "accepted")
  	end

  	describe "Signed-in user who has not completed profile information" do
    	before { sign_in user}

    	it {should have_link("Request Authorizations")}
    	it {should have_link("Request Referrals")}
    	it {should_not have_link("Grant Authorizations")}
    	it {should_not have_link("Grant Referrals")}
    	it {should_not have_link("Alarms")}

    	describe "should not appear in the member index" do 
    		before do 
    			visit users_path
    			fill_in "Screen Name", with: user.screen_name
    			click_button "Search"
    		end 
            it { should_not have_content(user.screen_name) }
        end

    	describe "should be able to read All Users page" do 
    		before { visit users_path }
            it { should have_selector('title', text: 'All Members') }
        end

        describe "should be able to read All Posts page" do 
    		before { visit posts_path }
            it { should have_selector('title', text: 'All Posts') }
        end

        describe "should be able to read My Alerts page" do 
    		before { visit my_alerts_path }
            it { should have_selector('title', text: 'Activity Alerts') }
        end

        describe "should NOT be able to create posts" do 
    		before do
    			visit root_path
    			click_button "Save"
    		end  
            it { should have_content('Sorry') }
        end

        describe "should NOT be able to create comments" do 
    		before do
    			visit new_post_comment_path(post)
    			click_button "Submit Comment"
    		end 
    		it { should have_content('Sorry') }
        end

        describe "should NOT be able to add rating" do 
    		before do
    			visit new_post_rating_path(post)
    			click_button "Create Rating"
    		end 
    		it { should have_content('Sorry') }
        end

        describe "should NOT be able to request referrals" do 
    		before do
    			visit new_referral_path
    			fill_in "First Name", with: "Robin"
    			click_button "Search"
    		end 
    		it { should have_content("you can't request any referral") }
        end

        describe "should NOT be able to request authorizations" do 
    		before do
    			visit new_authorization_path
    			fill_in "First Name", with: "Robin"
    			click_button "Search"
    		end 
    		it { should have_content("you can't request any authorization") }
        end
    end

    describe "Signed-in user who has completed profile information" do
    	before do
    		sign_in user
    		visit edit_user_path(user)
    		fill_in "School name", with: "Test School"
    		select "10", from: "Grade"
    		fill_in "My parent's email", with: "test@shooloo.org"
    		click_button "Update My Information"
    	end

    	describe "should appear in the member index" do 
    		before do 
    			visit users_path
    			fill_in "Screen Name", with: user.screen_name
    			click_button "Search"
    		end 
            it { should have_content(user.role) }
        end
        describe "should be able to request referrals" do 
    		before do
    			visit new_referral_path
    			fill_in "First Name", with: "Robin"
    			click_button "Search"
    		end 
    		it { should have_button("Request Referral") }

    		describe "and request of referral should be processed" do
    			before do
    				click_button "Request Referral"
    			end
    			it {should have_content("Request sent")} 
    		end
        end

        describe "should be able to request authorizations" do 
    		before do
    			visit new_authorization_path
    			fill_in "First Name", with: "Robin"
    			click_button "Search"
    		end 
    		it { should have_button("Request Authorization") }

    		describe "and request of authorization should be processed" do
    			before {click_button "Request Authorization"}
    			it {should have_content("Request sent")} 
    		end
        end
    end

    describe "referral grant pages" do
    	before do
    		referrer = FactoryGirl.create(:user)
    		referrer.authorizations.create!(authorizer_id: poster.id, approval: "accepted")
    		user.referrals.create!(referrer_id: referrer.id)
    		sign_in referrer
    	end

    	it {should_not have_link("Request Authorizations")}
    	it {should_not have_link("Request Referrals")}
    	it {should_not have_link("Grant Authorizations")}
    	it {should have_link("Grant Referrals")}
    	it {should_not have_link("Alarms")}

    	describe "referrer should be able to grant referrals" do 
    		before { visit referrals_path }
    		it {should have_content(user.first_name)}

    		describe "and referral should be processed once referrer complete reference check" do
    			#choose('ref_check_name_true_true')
                before {State.create!(user_id: user.id, complete: true)}
                it {should have_content("you granted referral")}
    		end
    	end
    end
  end
end
