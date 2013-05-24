class ChangeGradeToUsers < ActiveRecord::Migration
  def up
	  connection.execute(%q{
	    alter table users
	    alter column grade
	    type integer using cast(grade as integer)
	  })
  end

  def down
  	change_column :users, :grade, :string
  end
end
