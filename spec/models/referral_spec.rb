require 'spec_helper'

describe Referral do
  let(:referred) { FactoryGirl.create(:user) }
  let(:referrer) { FactoryGirl.create(:user) }
  let(:referral) { referred.referrals.build(referrer_id: referrer.id) }

  subject { referral }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to referred_id" do
      expect do
        Referral.new(referred_id: referred.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end

  describe "referred methods" do    
    it { should respond_to(:referred, :referrer, :approval) }
    its(:referred) { should == referred }
    its(:referrer) { should == referrer }
  end

  describe "when referrer id is not present" do
    before { referral.referrer_id = nil }
    it { should_not be_valid }
  end

  describe "when referred id is not present" do
    before { referral.referred_id = nil }
    it { should_not be_valid }
  end  
end

