require 'spec_helper'

describe User do
  before {@user = User.new(first_name: "Example", 
    last_name: "User", 
    parent_email: "user@example.com",  
    grade: "3",
    screen_name: "some_user",
    password: "foobar",
    password_confirmation: "foobar", 
    privacy: true,
    rules: true,
    avatar: File.new(Rails.root + 'spec/support/math.jpg'))}

  subject {@user}

  it {should respond_to(
    :first_name, :last_name, 
    :parent_email, :personal_email,
    :password, :password_confirmation, :password_digest,
    :grade, :avatar, :privacy, :rules, :admin,
    :authenticate, :remember_token, 
    :posts, :feed, :comments, :ratings, :likes, :alarms, :activities,
    :relationships, :reverse_relationships,
    :followed_users, :followers, 
    :following?, :follow!
    ) }  

  it {should be_valid}
  it {should_not be_admin}

  describe "with admin attribute set to 'true'" do
    before do
      @user.save!
      @user.toggle!(:admin)
    end

    it { should be_admin }
  end

  describe "when user last_name is too long" do
  	before { @user.last_name = "a" * 26}
  	it {should_not be_valid}
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com 
                      user_at_foo.org 
                      example.user@foo.
                      foo@bar_baz.com 
                      foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.parent_email = invalid_address
        @user.should_not be_valid
      end      
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM 
                     A_US-ER@f.b.org 
                     frst.lst@foo.jp 
                     a+b@baz.cn]
      addresses.each do |valid_address|
        @user.parent_email = valid_address
        @user.should be_valid
      end      
    end
  end

  describe "email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

    it "should be saved as all lower-case" do
      @user.parent_email = mixed_case_email
      @user.update_attributes!(grade: 9)
      @user.reload.parent_email.should == mixed_case_email.downcase
    end
  end

  describe "when screen_name is already taken" do
  	before do
      user_with_same_screen_name = @user.dup
      user_with_same_screen_name.save
    end

    it { should_not be_valid }
  end

  describe "when password is not present" do
    before { @user.password = @user.password_confirmation = ""}
    it {should_not be_valid}
  end

  describe "when password does not match password_confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it {should_not be_valid}
  end

  describe "when password_confirmation is nil" do
    before { @user.password_confirmation = nil }
    it {should_not be be_valid}
  end

  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by_screen_name(@user.screen_name) }

    describe "with valid password" do
      it { should == found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
  end
  
  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end

  describe "post associations" do

    before { @user.save }
    let!(:older_post) do 
      FactoryGirl.create(:post, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_post) do
      FactoryGirl.create(:post, user: @user, created_at: 1.hour.ago)
    end
    let!(:post) { FactoryGirl.create(:post)  }
    let!(:comment) do
      FactoryGirl.create(:comment, commenter: @user, commented_post: post)
    end

    it "should have the right posts in the right order" do
      @user.posts.should == [newer_post, older_post]
    end

    it "should destroy associated posts" do
      posts = @user.posts.dup
      @user.destroy
      posts.should_not be_empty
      posts.each do |post|
        Post.find_by_id(post.id).should be_nil
      end
    end

    it "should destroy associated comments" do
      comments = @user.comments.dup
      @user.destroy
      comments.should_not be_empty
      comments.each do |comment|
        Comment.find_by_id(comment.id).should be_nil
      end
    end

    describe "status" do
      let(:unfollowed_post) do
        FactoryGirl.create(:post, user: FactoryGirl.create(:user))
      end
      let(:followed_user) { FactoryGirl.create(:user) }

      before do
        @user.follow!(followed_user)
        3.times { followed_user.posts.create!(question: "Lorem ipsum", 
                  answer: "Lorem ipsum", 
                  grade: "5", 
                  category: "books", 
                  photo: File.new(Rails.root + 'spec/support/math.jpg') ) }
      end

      its(:feed) { should include(newer_post) }
      its(:feed) { should include(older_post) }
      its(:feed) { should_not include(unfollowed_post) }
      its(:feed) do
        followed_user.posts.each do |post|
          should include(post)
        end
      end
    end
  end

  describe "following" do
    let(:other_user) { FactoryGirl.create(:user) }    
    before do
      @user.save
      @user.follow!(other_user)
    end

    it { should be_following(other_user) }
    its(:followed_users) { should include(other_user) }

    describe "followed user" do
      subject { other_user }
      its(:followers) { should include(@user) }
    end

    describe "and unfollowing" do
      before { @user.unfollow!(other_user) }

      it { should_not be_following(other_user) }
      its(:followed_users) { should_not include(other_user) }
    end
  end
end

