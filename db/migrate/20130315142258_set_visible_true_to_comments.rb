class SetVisibleTrueToComments < ActiveRecord::Migration
  def up
  	#if Comment.count > 0
  		#Comment.update_all(['visible=true'],'visible is null')
  	#end
  	add_column :comments, :visible, :boolean, default: true
  end

  def down
  end
end
