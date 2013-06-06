require 'spec_helper'

describe State do
  before do
  	@user = FactoryGirl.create(:user) 
    @user.update_attributes(school_name: "Test School")
    @user.save!
  end

  @user.states.should_not == []
end
