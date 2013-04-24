class UpdateStatsToUsers < ActiveRecord::Migration
  def change
  	User.all.each do |u|
  		u.update_attributes!(posts_count: u.posts.count)
  		u.update_attributes!(rated_posts_count: u.rated_posts.count)
  		u.update_attributes!(commented_posts_count: u.commented_posts.count)
  		u.update_attributes!(followers_count: u.followers.count)
  		u.update_attributes!(followed_users_count: u.followed_users.count)
  		u.update_attributes!(privacy: true)
  		u.update_attributes!(rules: true)
  	end
  end
end
