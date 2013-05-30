require 'spec_helper'

describe Ability do
	let(:user) {FactoryGirl.create(:user)}
	let(:referrer) {FactoryGirl.create(:user)}
	let(:authorizer) {FactoryGirl.create(:user)}

	describe "a user signed in but with no referral or authorization" do
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

	describe "a teacher has authorization" do
		before do
			15.times {FactoryGirl.create(:user)}
		   	authorizer = FactoryGirl.create(:user, role: "teacher", visible: true)
			User.all.each do |user|			
				user.authorizations.create!(authorizer_id: authorizer.id)
			end
			@ability = Ability.new(authorizer)
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
end