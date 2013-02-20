# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Operation.create([
	{name: 'whole number'},
	{name: 'decimal point'},
	{name: 'fraction'},
	{name: 'percentage'},
	{name: 'negative number'},
	{name: 'addition'},
	{name: 'substraction'},
	{name: 'multiplication'},
	{name: 'division'}
	])

Improvement.create([
	{name: 'vocabulary'},
	{name: 'grammer'},
	{name: 'structure'},
	{name: 'concept clarity'},
	{name: 'originality'}
	])

Flag.create([
	{name: 'plagerized content'},
	{name: 'offensive content'},
	{name: 'offensive image'}
	])

admin1 = User.create([
	{first_name: 'Robin', 
		last_name: 'Yang',
		email: 'yyynyc@gmail.com',
		email_confirmation: 'yyynyc@gmail.com',
		grade: 'Tutor',
		screen_name: 'Elda_Hills', 
		password: 'adminshooloo',
		password_confirmation: 'adminshooloo', 
		avatar: File.new(Rails.root + 'app/assets/images/Elda.jpg')}    
	])

admin2 = User.create([
	{first_name: 'Robin',
		last_name: 'Yang',
		email: 'ryang@prosperityprana.com',	
		email_confirmation: 'ryang@prosperityprana.com',
		grade: 'Tutor',
		screen_name: 'Enchanted_Collar',
		password: 'adminshooloo',
		password_confirmation: 'adminshooloo',                 
		avatar: File.new(Rails.root + 'app/assets/images/enchanted.jpg')}    
	])

