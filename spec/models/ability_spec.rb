require 'spec_helper'

describe Ability do
	let(:user) {FactoryGirl.create(:user)}
	let(:referrer) {FactoryGirl.create(:user)}
	let(:authorizer) {FactoryGirl.create(:user)}

	describe "a user signed up but not completed information" do
		before {@ability = Ability.new(user)}

		it "should not be able to unalarm posts" do
			@ability.cannot?(:destroy, Alarm).should be_true
		end

		it "should not be able to create posts" do
			@ability.cannot?(:create, Post).should be_true
		end

		it "should not be able to create comments" do
			@ability.cannot?(:create, Comment).should be_true
		end

		it "should not be able to follow others" do
			@ability.cannot?(:create, Relationship).should be_true
		end

		it "should not be able to like others posts and comments" do
			@ability.cannot?(:create, Like).should be_true
		end

		it "should not be able to nudge others" do
			@ability.cannot?(:create, Nudge).should be_true
		end

		it "should be not able to create ratings" do
			@ability.cannot?(:create, Rating).should be_true
		end

		it "should not be able to raise alarms" do
			@ability.cannot?(:create, Alarm).should be_true
		end

		it "should NOT be able to request referrals" do
			@ability.cannot?(:create, Referral).should be_true
		end

		it "should NOT be able to request authorizations" do
			@ability.cannot?(:create, Authorization).should be_true
		end

		it "should be able to change read button to unread in my alerts" do
			@ability.can?(:update, Activity).should be_true
		end

		it "should be able to read everything" do
			@ability.can?(:read, :all).should be_true
		end
	end

	describe "user completed information but has no referral nor authorization" do
		before do
			user.update_attributes!(school_name: "Test School")
			@ability = Ability.new(user)
		end

		it "should not be able to unalarm posts" do
			@ability.cannot?(:destroy, Alarm).should be_true
		end

		it "should not be able to create posts" do
			@ability.cannot?(:create, Post).should be_true
		end

		it "should not be able to create comments" do
			@ability.cannot?(:create, Comment).should be_true
		end

		it "should not be able to follow others" do
			@ability.cannot?(:create, Relationship).should be_true
		end

		it "should not be able to like others posts and comments" do
			@ability.cannot?(:create, Like).should be_true
		end

		it "should not be able to nudge others" do
			@ability.cannot?(:create, Nudge).should be_true
		end

		it "should be not able to create ratings" do
			@ability.cannot?(:create, Rating).should be_true
		end

		it "should not be able to raise alarms" do
			@ability.cannot?(:create, Alarm).should be_true
		end

		it "should be able to request referrals" do
			@ability.can?(:create, Referral).should be_true
		end

		it "should be able to request authorizations" do
			@ability.can?(:create, Authorization).should be_true
		end

		it "should be able to change read button to unread in my alerts" do
			@ability.can?(:update, Activity).should be_true
		end

		it "should be able to read everything" do
			@ability.can?(:read, :all).should be_true
		end
	end

	describe "a user has referral but no authorization" do
		before do
			user.update_attributes!(school_name: "Test School")
			user.referrals.create!(referrer_id: referrer.id, 
				approval: "accepted")
			@ability = Ability.new(user)
		end 

		it "should not be able to unalarm posts" do
			@ability.cannot?(:destroy, Alarm).should be_true
		end
		
		it "should not be able to create posts" do
			@ability.cannot?(:create, Post).should be_true
		end

		it "should not be able to create comments" do
			@ability.cannot?(:create, Comment).should be_true
		end

		it "should be able to follow others" do
			@ability.can?(:create, Relationship).should be_true
		end

		it "should be able to like others posts and comments" do
			@ability.can?(:create, Like).should be_true
		end

		it "should be able to nudge others" do
			@ability.can?(:create, Nudge).should be_true
		end

		it "should be able to create ratings" do
			@ability.can?(:create, Rating).should be_true
		end

		it "should be able to raise alarms" do
			@ability.can?(:create, Alarm).should be_true
		end

		it "should NOT be able to request referrals" do
			@ability.cannot?(:create, Referral).should be_true
		end

		it "should be able to request authorizations" do
			@ability.can?(:create, Authorization).should be_true
		end

		it "should be able to change read button to unread in my alerts" do
			@ability.can?(:update, Activity).should be_true
		end

		it "should be able to read everything" do
			@ability.can?(:read, :all).should be_true
		end
	end

	describe "a user has authorization" do
		before do
			user.authorizations.create!(authorizer_id: authorizer.id, 
				approval: "accepted")
			@ability = Ability.new(user)
		end 

		it "should not be able to unalarm posts" do
			@ability.cannot?(:destroy, Alarm).should be_true
		end
		
		it "should be able to create posts" do
			@ability.can?(:create, Post).should be_true
		end

		it "should be able to delete posts" do
			@ability.can?(:destroy, Post).should be_true
		end

		it "should be able to create comments" do
			@ability.can?(:create, Comment).should be_true
		end

		it "should be able to follow others" do
			@ability.can?(:create, Relationship).should be_true
		end

		it "should be able to like others posts and comments" do
			@ability.can?(:create, Like).should be_true
		end

		it "should be able to nudge others" do
			@ability.can?(:create, Nudge).should be_true
		end

		it "should be able to create ratings" do
			@ability.can?(:create, Rating).should be_true
		end

		it "should be able to raise alarms" do
			@ability.can?(:create, Alarm).should be_true
		end

		it "should NOT be able to request referrals" do
			@ability.cannot?(:create, Referral).should be_true
		end

		it "should NOT be able to request authorizations" do
			@ability.cannot?(:create, Authorization).should be_true
		end

		it "should be able to change read button to unread in my alerts" do
			@ability.can?(:update, Activity).should be_true
		end

		it "should be able to read everything" do
			@ability.can?(:read, :all).should be_true
		end
	end

	describe "a teacher has authorization" do
		let(:user) {FactoryGirl.create(:user, role: "teacher", 
			visible: true)}
		before do
		user.referrals.create!(referrer_id: referrer.id, approval: "accepted") 
			15.times do |n|
				User.create!(screen_name: "factory_#{n+1}", 
					password: "shooloo", 
					password_confirmation: "shooloo", 
					privacy: true, rules: true).authorizations.create!(
					authorizer_id: user.id)
			end 
			@ability = Ability.new(user)
		end 
		
		it "should be able to unalarm posts" do
			@ability.can?(:manage, Alarm).should be_true
		end

		it "should be able to create posts" do
			@ability.can?(:create, Post).should be_true
		end

		it "should be able to create comments" do
			@ability.can?(:create, Comment).should be_true
		end

		it "should be able to follow others" do
			@ability.can?(:create, Relationship).should be_true
		end

		it "should be able to like others posts and comments" do
			@ability.can?(:create, Like).should be_true
		end

		it "should be able to nudge others" do
			@ability.can?(:create, Nudge).should be_true
		end

		it "should be able to create ratings" do
			@ability.can?(:create, Rating).should be_true
		end

		it "should be able to raise alarms" do
			@ability.can?(:create, Alarm).should be_true
		end

		it "should NOT be able to request referrals" do
			@ability.cannot?(:create, Referral).should be_true
		end

		it "should be able to request authorizations" do
			@ability.can?(:create, Authorization).should be_true
		end

		it "should be able to change read button to unread in my alerts" do
			@ability.can?(:update, Activity).should be_true
		end

		it "should be able to read everything" do
			@ability.can?(:read, :all).should be_true
		end
	end
end