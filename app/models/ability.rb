class Ability
    include CanCan::Ability

    def initialize(user)
        user ||= User.new # guest user (not logged in)

        alias_action :read, :create, :update, :destroy, :to => :crud

        if user.admin?
            can :manage, :all
        elsif user.role == "teacher" && 
            user.referrals.where(approval: "accepted").any? &&
            user.authorized_users.count >=15
            can :update, Authorization
            can :manage, Alarm
            can :crud, [Post, Comment, Rating]
            can :update, Referral
            can [:create, :destroy], [Like, Relationship, Nudge]
            can :read, :all
            can :update, Activity
            can :create, [Referral, Authorization]
            can :update, User do |guest|
              User.try(:user) == user || user.admin?
            end
        elsif user.authorizations.where(approval: "accepted").any?
            can :crud, [Post, Comment, Rating]
            can :update, Referral
            can [:create, :destroy], [Like, Relationship, Nudge]
            can :create, Alarm
            can :read, :all
            can :update, Activity
            can :create, [Referral, Authorization]
            can :update, User do |guest|
              User.try(:user) == user || user.admin?
            end
        elsif user.referrals.where(approval: "accepted").any?
            can [:create, :destroy], [Like, Relationship, Nudge]
            can :crud, Rating
            can :create, Alarm
            can :update, Activity
            can :create, [Referral, Authorization]
            can :update, User do |guest|
              User.try(:user) == user || user.admin?
            end 
            can :read, :all
        else
            can :read, :all
            can :update, Activity
            can :create, [Referral, Authorization]
            can :update, User do |guest|
              User.try(:user) == user || user.admin?
            end
        end        
    end
end


