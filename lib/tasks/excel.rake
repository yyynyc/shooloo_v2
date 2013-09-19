namespace :db do
  desc "export data to spreadsheet"
  task populate: :environment do
    export_users
  end
end

def export_users
	File.open
	User.all.each do |user|
	end
end
