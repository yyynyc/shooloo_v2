require 'spec_helper'

describe "UserPages" do
  subject {page}

  describe "signup" do
    before { visit signup_path }
    let(:submit) { "Create My Account" }

    describe "page" do
      it {should have_selector('h1', text: 'Sign Up')}
      it {should have_selector('title', text: full_title('Sign Up'))}
    end

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button "Create My Account" }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button "Create My Account" }

        it { should have_selector('title', text: 'Sign Up') }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before do
        select "student", from: 'user_role'
        fill_in 'user_screen_name', with: "Test_User"
        fill_in 'user_password', with: "foobar"
        fill_in 'user_password_confirmation', with: "foobar"
        check 'user_privacy'
        check 'user_rules'
      end

      it "should create a user" do
        expect { click_button "Create My Account" }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button "Create My Account"}
        let(:user) { User.find_by_screen_name('Test_User') }

        it { should have_selector('div.alert.alert-success', text: 'Welcome to Shooloo Learning!') }
        it { should have_link('Alerts')}
      end
    end

    describe "edit without any accepted authorization or referral" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        sign_in user
        visit edit_user_path(user)
      end

      describe "page" do
        it { should have_selector('h1', text: "Update Your Information") }
        it { should have_selector('title', text: "Edit user") } 
        it { should have_field ("First name")}     
      end

      
      describe "with invalid information" do
        let(:new_email) {"new@example"}
        before do
          fill_in "My parent's email", with: new_email
          click_button "Update My Information"
        end  

        it { should have_content('error') }
      end

      describe "with valid information" do
        let(:new_name)  { "New_Name" }
        let(:new_email) { "new@example.com" }
        before do
          fill_in 'user_first_name', with: user.first_name
          fill_in 'user_last_name', with: user.last_name
          fill_in 'user_screen_name', with: new_name
          fill_in 'user_parent_email', with: new_email
          fill_in 'user_school_name', with: "New School"
          select "4", from: 'user_grade'
          attach_file 'user_avatar', Rails.root.join('spec', 'support', 'math.jpg')
          check 'user_privacy'
          check 'user_rules'
          click_button "Update My Information"
        end

        it { should have_selector('title', text: full_title('My Abilities'))}
        it { should have_selector('div.alert.alert-success') }
        it { should have_link('Sign Out', href: signout_path) }
        specify { user.reload.screen_name.should  == new_name }
        specify { user.reload.parent_email.should == new_email }
      end
    end

    describe "edit with accepted authorization" do
      let(:user) { FactoryGirl.create(:user) }
      let(:authorizer) { FactoryGirl.create(:user)}
      before do
        sign_in user
        user.authorizations.create!(authorizer_id: authorizer.id, 
        approval: "accepted")
        visit edit_user_path(user)
      end
      
      it {should_not have_field("First name")}
      it {should_not have_field("Last name")}
    end

    describe "edit with acceptedt referral" do
      let(:user) { FactoryGirl.create(:user) }
      let(:referrer) { FactoryGirl.create(:user)}
      before do
        sign_in user
        user.referrals.create!(referrer_id: referrer.id, 
        approval: "accepted")
        visit edit_user_path(user)
      end
      
      it {should_not have_field("First name")}
      it {should_not have_field("Last name")}
    end
  end

  describe "index" do
    let(:user) { FactoryGirl.create(:user, visible: true) }

    before(:each) do
      sign_in user
      visit users_path
    end

    it { should have_selector('title', text: full_title('All Members')) }
    it { should have_selector('h1',    text: 'All Shooloo Members') }

    describe "pagination" do

      before(:all) { 30.times { FactoryGirl.create(:user, visible: true) } }
      after(:all)  { User.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each user" do
        User.paginate(order: 'screen_name ASC', page: 1).each do |user|
          page.should have_selector('li', text: user.screen_name)
        end
      end
    end

    describe "delete links" do

      it { should_not have_link('delete') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin, visible: true) }
        before do
          sign_in admin
          visit users_path
        end

        it { should have_link('delete', href: user_path(User.first)) }
        it "should be able to delete another user" do
          expect { click_link('delete') }.to change(User, :count).by(-1)
        end
        it { should_not have_link('delete', href: user_path(admin)) }
      end
    end 
  end

  describe "my alerts page" do
    before do
      sign_in FactoryGirl.create(:user)
      visit my_alerts_path
    end

    it {should have_selector('h1', text: 'My News Alerts')}
    it {should have_selector('title', text: full_title('Activity Alerts'))}
  end

  describe "user's published post page" do
    let(:user) {FactoryGirl.create(:user)}
    let!(:m1) { FactoryGirl.create(:post, user: user, question: "Question 1", 
      answer: "Answer 1", grade: "2nd grade", category: "books", 
      photo: File.new(Rails.root + 'spec/support/math.jpg')) }
    let!(:m2) { FactoryGirl.create(:post, user: user, question: "Question 2", 
      answer: "Answer 2", grade: "5th grade", category: "money",
      photo: File.new(Rails.root + 'spec/support/math.jpg')) }
   
    before do
      sign_in user
      visit posts_user_path(user)
    end 

    it {should have_selector('h1', text: user.screen_name)}
    it {should have_selector('title', text: full_title(user.screen_name + '_Published_Posts'))}

    describe "posts" do
      it { should have_content(m1.question) }
      it { should have_content(m1.grade) }
      it { should have_content(m2.question) }
      it { should have_content(m2.grade) }
      it { should have_content(user.posts.count) }
    end

    describe "follow/unfollow buttons" do
      let(:other_user) { FactoryGirl.create(:user) }
      let(:referrer) { FactoryGirl.create(:user)}
      before { sign_in user }

      describe "when user does not have referral" do
        before { visit posts_user_path(other_user) }

        it "should not increment the followed user count" do
          expect do
            click_link "Follow"
          end.to change(user.followed_users, :count).by(0)
        end
      end

      describe "when user has referral" do
        before {user.referrals.create!(referrer_id: referrer.id, 
          approval: "accepted")} 

        describe "following a user" do
          before { visit posts_user_path(other_user) }

          it "should increment the followed user count" do
            expect do
              click_button "Follow"
            end.to change(user.followed_users, :count).by(1)
          end

          it "should increment the other user's followers count" do
            expect do
              click_button "Follow"
            end.to change(other_user.followers, :count).by(1)
          end

          describe "toggling the button" do
            before { click_button "Follow" }
            it { should have_selector('input', value: 'Unfollow') }
          end
        end

        describe "unfollowing a user" do
          before do
            user.follow!(other_user)
            visit posts_user_path(other_user)
          end

          it "should decrement the followed user count" do
            expect do
              click_button "Unfollow"
            end.to change(user.followed_users, :count).by(-1)
          end

          it "should decrement the other user's followers count" do
            expect do
              click_button "Unfollow"
            end.to change(other_user.followers, :count).by(-1)
          end

          describe "toggling the button" do
            before { click_button "Unfollow" }
            it { should have_selector('input', value: 'Follow') }
          end
        end
      end
    end
  end
end
