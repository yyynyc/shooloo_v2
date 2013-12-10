class Ability
    include CanCan::Ability

    def initialize(user)
        user ||= User.new  # guest user (not logged in)

        alias_action :read, :create, :update, :destroy, :to => :crud

        if user.admin?
            can :manage, :all
        elsif user.role == "teacher" && 
            user.authorizations.where(approval: "accepted").any?
            can :crud, [UserImport, Assignment, Response, Grading, Reminder]
            can [:crud, :comment, :comments], Lesson
            can :update, [Authorization, Referral]
            can [:create, :destroy], [Referral, Authorization]
            can :manage, Alarm
            can :teacher_view, Post
            can :crud, [Post, Comment, Invite, Rating]
            can [:create, :destroy], [Like, Relationship, Nudge]
            can :read, :all
            can :crud 
            can [:index, :show, :pd], Video       
        elsif user.authorizations.where(approval: "accepted").any?
            can :crud, Response
            can :update, Referral
            can [:create, :destroy], [Referral, Authorization]
            can :crud, [Post, Comment, Invite, Rating]
            can [:create, :destroy], [Like, Relationship, Nudge]
            can :create, Alarm
            can :read, :all
            can :crud, Activity
            can [:index, :show], Video
        elsif user.referrals.where(approval: "accepted").any?
            can [:create, :destroy], [Referral, Authorization]
            can [:create, :destroy], [Like, Relationship, Nudge]
            can :crud, Rating
            can :create, Alarm
            can :crud, Activity
            can :read, :all
            can [:index, :show], Video
        elsif !user.state.nil? && user.state.complete?
            can [:create, :destroy], [Referral, Authorization]
            can [:new], [Comment, Assignment, Lesson]
            can [:new, :teacher_view], Post
            can :read, :all
            can :crud, [Activity, Keep]
            can [:index, :show], Video
        else
            can :read, :all
            can :crud, Activity
            can [:index, :show], Video
        end        
    end
end


