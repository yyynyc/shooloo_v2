every :day, :at => '3:00 am' do
	runner "Activity.destroy_old_data"
end

every :day, :at => '4:00 am' do
	runner "Nudge.destroy_old_data"
end

every :day, :at => '5:00 am' do
	runner "User.daily_alert"
end


# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
