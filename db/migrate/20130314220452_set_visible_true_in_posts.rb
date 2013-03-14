class SetVisibleTrueInPosts < ActiveRecord::Migration
  def up
  	if Post.count > 0
  		Post.update_all(['visible=true'],'visible is null')
  	end
  end

  def down
  end
end
