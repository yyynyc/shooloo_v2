require 'spec_helper'

describe "AuthenticationPages" do
	describe "Authentication" do

		subject { page }

		describe "signin page" do
  		before { visit signin_path }

  		it { should have_selector('h1',    text: 'Sign In') }
  		it { should have_selector('title', text: 'Sign In') }
		end

		describe "signin" do
  		before { visit signin_path }

 			describe "with invalid information" do
  			before { click_button "Sign in" }

  			it { should have_selector('title', text: 'Sign In') }
  			it { should have_selector('div.alert.alert-error', text: 'Invalid') }

  			describe "after visiting another page" do
    		before { click_link "Home" }
    		it { should_not have_selector('div.alert.alert-error') }
  			end
  		end

  		 describe "with valid information" do
  			let(:user) { FactoryGirl.create(:user) }
  			before { sign_in user }

  			it { should have_selector('title', text: "Activity Alerts") }
  			it { should have_link('My Published Posts', href: posts_user_path(user)) }
        it { should have_link('All Users',    href: users_path) }
        it { should have_link('My Information',    href: edit_user_path(user)) }
  		  it { should have_link('Sign Out', href: signout_path) }
  			it { should_not have_link('Sign in', href: signin_path) }

  			describe "followed by signout" do
    			before { click_link "Sign Out" }
    			it { should have_link('Sign in') }
  			end
		  end
		end
    describe "authorization" do

      describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

        describe "in the Users controller" do

          describe "visiting the edit page" do
            before { visit edit_user_path(user) }
            it { should have_selector('title', text: 'Sign In') }
          end

          describe "visiting the user index" do
            before { visit users_path }
            it { should have_selector('title', text: 'Sign In') }
          end

          describe "visiting the my alerts page" do
            before { visit my_alerts_path }
            it { should have_selector('title', text: 'Sign In') }
          end

          describe "submitting to the update action" do
            before { put user_path(user) }
            specify { response.should redirect_to(signin_path) }
          end

          describe "visiting the following page" do
            before { visit following_user_path(user) }
            it { should have_selector('title', text: 'Sign In') }
          end

          describe "visiting the followers page" do
            before { visit followers_user_path(user) }
            it { should have_selector('title', text: 'Sign In') }
          end
        end 

        describe "in the Relationships controller" do
          describe "submitting to the create action" do
            before { post relationships_path }
            specify { response.should redirect_to(signin_path) }
          end

          describe "submitting to the destroy action" do
            before { delete relationship_path(1) }
            specify { response.should redirect_to(signin_path) }          
          end
        end     

        describe "in the Posts controller" do

          describe "visiting the post index" do
            before { visit posts_path }
            it { should have_selector('title', text: 'Sign In') }
          end

          describe "submitting to the create action" do
            before { post posts_path }
            specify { response.should redirect_to(signin_path) }
          end

          describe "submitting to the destroy action" do
            before { delete post_path(FactoryGirl.create(:post)) }
            specify { response.should redirect_to(signin_path) }
          end
        end

        describe "when attempting to visit a protected page" do
          before do
            visit users_path
            fill_in "Screen Name", with: user.screen_name
            fill_in "Password", with: user.password
            click_button "Sign in"
          end

          describe "after signing in" do

            it "should render the desired protected page" do
              page.should have_selector('title', text: full_title('All Members'))
            end
          end

          describe "when signing in again" do
            before do
              delete signout_path
              visit signin_path
              fill_in "Screen Name", with: user.screen_name
              fill_in "Password", with: user.password
              click_button "Sign in"
            end

            it "should render the default (alerts) page" do
              page.should have_selector('title', text: "Activity Alerts") 
            end
          end
        end
      end
    end

    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, 
                        screen_name: "wrong_user") }
      before { sign_in user }

      describe "visiting Users#edit page" do
        before { visit edit_user_path(wrong_user) }
        it { should_not have_selector('title', text: full_title('Edit user')) }
      end

      describe "submitting a PUT request to the Users#update action" do
        before { put user_path(wrong_user) }
        specify { response.should redirect_to(root_path) }
      end
    end

    describe "as non-admin user" do
      let(:user) {FactoryGirl.create(:user)}
      let(:non_admin) {FactoryGirl.create(:user)}

      before { sign_in non_admin }

      describe "submitting a DELETE request to the Users#destroy action" do
        before {delete user_path(user)}
        specify {response.should redirect_to(root_path)}
      end
    end
	end
end
