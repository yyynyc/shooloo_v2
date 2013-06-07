require 'spec_helper'

describe State do
  before do
  	@user = FactoryGirl.create(:user) 
    @user.update_attributes(school_name: "Test School")
    @user.save!
  end

  it "a new record in State should be automatically created once a user completes profile info" do
  	@user.states.should_not be_empty
  end
end
