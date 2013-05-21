require 'spec_helper'

describe Authorization do
  let(:authorized) { FactoryGirl.create(:user) }
  let(:authorizer) { FactoryGirl.create(:user) }
  let(:authorization) { authorized.authorizations.build(authorizer_id: authorizer.id) }

  subject { authorization }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to authorized_id" do
      expect do
        Authorization.new(authorized_id: authorized.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end

  describe "authorized methods" do    
    it { should respond_to(:authorized, :authorizer, :approval) }
    its(:authorized) { should == authorized }
    its(:authorizer) { should == authorizer }
  end

  describe "when authorizer id is not present" do
    before { authorization.authorizer_id = nil }
    it { should_not be_valid }
  end

  describe "when authorized id is not present" do
    before { authorization.authorized_id = nil }
    it { should_not be_valid }
  end  
end
