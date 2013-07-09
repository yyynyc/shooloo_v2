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

if Grade.count==0
	Grade.create([
		{number: 0, name: 'Kindergarten'},
		{number: 1, name: '1st Grade'},
		{number: 2, name: '2nd Grade'},
		{number: 3, name: '3rd Grade'},
		{number: 4, name: '4th Grade'},
		{number: 5, name: '5th Grade'},
		{number: 6, name: '6th Grade'},
		{number: 7, name: '7th Grade'},
		{number: 8, name: '8th Grade'}
		])
end

if Domain.count==0
	Domain.create([
		{grade_id: 1, name: 'Math Operations & Algebra (Grade K)', symbol: 'K.OA'},
		{grade_id: 1, name: 'Numbers & Place Value (Grade K)', symbol: 'K.NBT'},
		{grade_id: 1, name: 'Measurement & Data (Grade K)', symbol: 'K.MD'},
		{grade_id: 1, name: 'Geometry (Grade K)', symbol: 'K.G'},
		{grade_id: 2, name: 'Math Operations & Algebra (Grade 1)', symbol: '1.OA'},
		{grade_id: 2, name: 'Numbers & Place Value (Grade 1)', symbol: '1.NBT'},
		{grade_id: 2, name: 'Measurement & Data (Grade 1)', symbol: '1.MD'},
		{grade_id: 2, name: 'Geometry (Grade 1)', symbol: '1.G'},
		{grade_id: 3, name: 'Math Operations & Algebra (Grade 2)', symbol: '2.OA'},
		{grade_id: 3, name: 'Numbers & Place Value (Grade 2)', symbol: '2.NBT'},
		{grade_id: 3, name: 'Measurement & Data (Grade 2)', symbol: '2.MD'},
		{grade_id: 3, name: 'Geometry (Grade 2)', symbol: '2.G'},
		{grade_id: 4, name: 'Math Operations & Algebra (Grade 3)', symbol: '3.OA'},
		{grade_id: 4, name: 'Numbers & Place Value (Grade 3)', symbol: '3.NBT'},
		{grade_id: 4, name: 'Measurement & Data (Grade 3)', symbol: '3.MD'},
		{grade_id: 4, name: 'Geometry (Grade 3)', symbol: '3.G'},
		{grade_id: 4, name: 'Fractions (Grade 3)', symbol: '3.NF'},
		{grade_id: 5, name: 'Math Operations & Algebra (Grade 4)', symbol: '4.OA'},
		{grade_id: 5, name: 'Numbers & Place Value (Grade 4)', symbol: '4.NBT'},
		{grade_id: 5, name: 'Measurement & Data (Grade 4)', symbol: '4.MD'},
		{grade_id: 5, name: 'Geometry (Grade 4)', symbol: '4.G'},
		{grade_id: 5, name: 'Fractions (Grade 4)', symbol: '4.NF'},
		{grade_id: 6, name: 'Math Operations & Algebra (Grade 5)', symbol: '5.OA'},
		{grade_id: 6, name: 'Numbers & Place Value (Grade 5)', symbol: '5.NBT'},
		{grade_id: 6, name: 'Measurement & Data (Grade 5)', symbol: '5.MD'},
		{grade_id: 6, name: 'Geometry (Grade 5)', symbol: '5.G'},
		{grade_id: 6, name: 'Fractions (Grade 5)', symbol: '5.NF'},
		{grade_id: 7, name: 'Ratios & Proportions (Grade 6)', symbol: '6.RP'},
		{grade_id: 7, name: 'Number System (Grade 6)', symbol: '6.NS'},
		{grade_id: 7, name: 'Expressions & Equations (Grade 6)', symbol: '6.EE'},
		{grade_id: 7, name: 'Geometry (Grade 6)', symbol: '6.G'},
		{grade_id: 7, name: 'Statistics & Probability (Grade 6)', symbol: '6.SP'},
		{grade_id: 8, name: 'Ratios & Proportions (Grade 7)', symbol: '7.RP'},
		{grade_id: 8, name: 'Number System (Grade 7)', symbol: '7.NS'},
		{grade_id: 8, name: 'Expressions & Equations (Grade 7)', symbol: '7.EE'},
		{grade_id: 8, name: 'Geometry (Grade 7)', symbol: '7.G'},
		{grade_id: 8, name: 'Statistics & Probability (Grade 7)', symbol: '7.SP'},
		{grade_id: 9, name: 'Number System (Grade 8)', symbol: '8.NS'},
		{grade_id: 9, name: 'Expressions & Equations (Grade 8)', symbol: '8.EE'},
		{grade_id: 9, name: 'Geometry (Grade 8)', symbol: '8.G'},
		{grade_id: 9, name: 'Statistics & Probability (Grade 8)', symbol: '8.SP'},
		{grade_id: 9, name: 'Functions (Grade 8)', symbol: '8.F'}
		])
end

if Standard.count==0
	Standard.create([
		{grade_id: 2, domain_id: 6, symbol: '1.NBT.1', description: 'Count to 120, starting at any number less than 120.', ICan: 'count to 120' },
		{grade_id: 2, domain_id: 6, symbol: '1.NBT.2', description: 'Understand that the two digits of a two-digit number represent amounts of tens and ones.', ICan: 'tell how many tens and how many ones are in a number' }
	])
end
