require 'spec_helper'

describe Nudge do
  let(:nudger) { FactoryGirl.create(:user) }
  let(:nudged) { FactoryGirl.create(:user) }
  let(:nudge) { nudger.nudges.build(nudged_id: nudged.id) }

  subject { nudge }

  it { should be_valid }

  describe "nudger methods" do    
    it { should respond_to(:nudger) }
    it { should respond_to(:nudged) } 
    its(:nudger) { should == nudger }
    its(:nudged) { should == nudged }
  end

  describe "when nudged id is not present" do
    before { nudge.nudged_id = nil }
    it { should_not be_valid }
  end

  describe "when nudger id is not present" do
    before { nudge.nudger_id = nil }
    it { should_not be_valid }
  end  
end
