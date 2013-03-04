# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Operation.create([
	{name: 'whole number', postion: 1},
	{name: 'decimal point', postion: 2},
	{name: 'fraction', postion: 3},
	{name: 'percentage', postion: 4},
	{name: 'negative number', postion: 5},
	{name: 'addition', postion: 6},
	{name: 'substraction', postion: 7},
	{name: 'multiplication', postion: 8},
	{name: 'division', postion: 9}
	])

Improvement.create([
	{name: 'vocabulary', postion: 1},
	{name: 'grammar', postion: 2},
	{name: 'structure', postion: 3},
	{name: 'concept clarity', postion: 4},
	{name: 'originality', postion: 5}
	])

Flag.create([
	{name: 'plagerized content', postion: 1},
	{name: 'offensive content', postion: 2},
	{name: 'offensive image', postion: 3}
	])

admin1 = User.create(
	{first_name: 'Robin', 
		last_name: 'Yang',
		email: 'yyynyc@gmail.com',
		email_confirmation: 'yyynyc@gmail.com',
		grade: 'Tutor',
		screen_name: 'Elda_Hills', 
		password: 'adminshooloo',
		password_confirmation: 'adminshooloo', 
		avatar: File.new(Rails.root + 'app/assets/images/Elda.jpg')}  
	)
admin1.admin = true
admin1.save!

admin2 = User.create(
	{first_name: 'Robin',
		last_name: 'Yang',
		email: 'ryang@prosperityprana.com',	
		email_confirmation: 'ryang@prosperityprana.com',
		grade: 'Tutor',
		screen_name: 'Enchanted_Collar',
		password: 'adminshooloo',
		password_confirmation: 'adminshooloo',                 
		avatar: File.new(Rails.root + 'app/assets/images/enchanted.jpg')}    
	)
admin2.admin = true
admin2.save!

