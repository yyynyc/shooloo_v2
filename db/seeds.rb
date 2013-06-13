# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
if Operation.count == 0
	Operation.create([
		{name: 'whole number', position: 1},
		{name: 'decimal point', position: 2},
		{name: 'fraction', position: 3},
		{name: 'percentage', position: 4},
		{name: 'negative number', position: 5},
		{name: 'addition', position: 6},
		{name: 'substraction', position: 7},
		{name: 'multiplication', position: 8},
		{name: 'division', position: 9}
		])
end

if Improvement.count == 0
	Improvement.create([
		{name: 'vocabulary', position: 1},
		{name: 'grammar', position: 2},
		{name: 'structure', position: 3},
		{name: 'concept clarity', position: 4},
		{name: 'originality', position: 5}
		])
end

if Flag.count == 0
	Flag.create([
		{name: 'plagerized content', position: 1},
		{name: 'offensive content', position: 2},
		{name: 'offensive image', position: 3}
		])
end

if User.count == 0
	admin1 = User.create(
		{first_name: 'Robin', 
			last_name: 'Yang',
			personal_email: 'yyynyc@gmail.com',
			grade: nil,
			screen_name: 'Elda_Hills', 
			password: 'admin1',
			password_confirmation: 'admin1', 
			privacy: true, 
			rules: true,
			role: 'tutor',
			visible: true,
			avatar: File.new(Rails.root + 'app/assets/images/Elda.jpg')}  
		)

	admin2 = User.create(
		{first_name: 'Robin',
			last_name: 'Yang',
			personal_email: 'ryang@prosperityprana.com',	
			grade: nil,
			screen_name: 'Enchanted_Collar',
			password: 'admin2',
			password_confirmation: 'admin2', 
			privacy: true,
			rules: true, 
			role: 'tutor', 
			visible: true,               
			avatar: File.new(Rails.root + 'app/assets/images/enchanted.jpg')}    
		)
	admin2.admin = true
	admin2.save!
end