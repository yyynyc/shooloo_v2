class Ability
    include CanCan::Ability

    def initialize(user)
        user ||= User.new  # guest user (not logged in)

        alias_action :read, :create, :update, :destroy, :to => :crud

        if user.admin?
            can :manage, :all
        else
            if user.role != "student" 
                can :crud, [UserImport, Grading, Reminder]
                can [:crud, :comment, :comments], Lesson
                can :update, [Authorization, Referral]
                can :manage, Alarm
                can [:draft, :corrected,:teacher_view], Post
            end
            if user.complete?
                can [:create, :destroy], [Referral, Authorization]
            end
            can :read, :all
            can :crud, [Post, Relationship, Like, Nudge, Comment, Assignment, Lesson, 
                Response, Invite, Activity, Keep]
            can [:index, :show, :premium, :pd], Video
        end        
    end
end


