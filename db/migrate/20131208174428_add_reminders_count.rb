class AddRemindersCount < ActiveRecord::Migration
  def up
  	add_column :responses, :reminders_count, :integer, default: 0

  	Response.reset_column_information
  	Response.all.each do |r|
  		r.update_attributes!(reminders_count: r.reminders.length)
  	end
  end

  def down
  	remove_column :responses, :reminders_count
  end
end
