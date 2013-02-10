class ChangeIdRatings < ActiveRecord::Migration
	def change
	  execute %q{
	    alter table ratings
	    alter column rater_id
	    type int using cast(rater_id as int)
	  }

	  execute %q{
	    alter table ratings
	    alter column rated_post_id
	    type int using cast(rated_post_id as int)
	  }
	end
end
