require 'spec_helper'

describe RefCheck do
  let(:referred) { FactoryGirl.create(:user) }
  let(:referrer) { FactoryGirl.create(:user) }
  let(:referral) { referred.referrals.create!(referrer_id: referrer.id) }
  let(:ref_check) { referral.ref_checks.create!(
  					name_true: true, role_true: true,
  					screen_name_appropriate: true, avatar_appropriate: true)}

  subject { ref_check }

  it { should be_valid }
  its(:referral) { should == referral }
  its(:referral) {should_receive(:update_attributes!)}

  describe "ref_checks methods" do    
    it { should respond_to(:referral_id, :name_true, :role_true,
  					:screen_name_appropriate, :avatar_appropriate) }
  end

  describe "when referreral id is not present" do
    before { ref_check.referral_id = nil }
    it { should_not be_valid }
  end

  describe "when name_true is not present" do
    before { ref_check.name_true = nil }
    it { should_not be_valid }
  end  

  describe "when role_true is not present" do
    before { ref_check.role_true = nil }
    it { should_not be_valid }
  end  

  describe "when screen_name_appropriate is not present" do
    before { ref_check.screen_name_appropriate = nil }
    it { should_not be_valid }
  end  

  describe "when avatar_appropriate is not present" do
    before { ref_check.avatar_appropriate = nil }
    it { should_not be_valid }
  end    
end



