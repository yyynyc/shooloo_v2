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
		{grade_id: 1, name: 'Addition & Substraction (Grade K)', symbol: 'K.OA', core: 'Operations & Algebraic Thinking'},
		{grade_id: 1, name: 'Numbers & Place Value (Grade K)', symbol: 'K.NBT', core: 'Number & Operations in Based Ten'},
		{grade_id: 1, name: 'Measurement & Data (Grade K)', symbol: 'K.MD', core: 'Measurement & Data'},
		{grade_id: 1, name: 'Geometry (Grade K)', symbol: 'K.G', core: 'Geometry'},
		{grade_id: 2, name: 'Math Operations & Algebra (Grade 1)', symbol: '1.OA', core: 'Operations & Algebraic Thinking' },
		{grade_id: 2, name: 'Numbers & Place Value (Grade 1)', symbol: '1.NBT', core: 'Number & Operations in Based Ten'},
		{grade_id: 2, name: 'Measurement & Data (Grade 1)', symbol: '1.MD', core: 'Measurement & Data'},
		{grade_id: 2, name: 'Geometry (Grade 1)', symbol: '1.G', core: 'Geometry'},
		{grade_id: 3, name: 'Math Operations & Algebra (Grade 2)', symbol: '2.OA', core: 'Operations & Algebraic Thinking'},
		{grade_id: 3, name: 'Numbers & Place Value (Grade 2)', symbol: '2.NBT', core: 'Number & Operations in Based Ten'},
		{grade_id: 3, name: 'Measurement & Data (Grade 2)', symbol: '2.MD', core: 'Measurement & Data'},
		{grade_id: 3, name: 'Geometry (Grade 2)', symbol: '2.G', core: 'Geometry'},
		{grade_id: 4, name: 'Math Operations & Algebra (Grade 3)', symbol: '3.OA', core: 'Operations & Algebraic Thinking'},
		{grade_id: 4, name: 'Numbers & Place Value (Grade 3)', symbol: '3.NBT', core: 'Number & Operations in Based Ten'},
		{grade_id: 4, name: 'Measurement & Data (Grade 3)', symbol: '3.MD', core: 'Measurement & Data'},
		{grade_id: 4, name: 'Geometry (Grade 3)', symbol: '3.G', core: 'Geometry'},
		{grade_id: 4, name: 'Fractions (Grade 3)', symbol: '3.NF', core: 'Number & Operations-Fractions'},
		{grade_id: 5, name: 'Math Operations & Algebra (Grade 4)', symbol: '4.OA', core: 'Operations & Algebraic Thinking'},
		{grade_id: 5, name: 'Numbers & Place Value (Grade 4)', symbol: '4.NBT', core: 'Number & Operations in Based Ten'},
		{grade_id: 5, name: 'Measurement & Data (Grade 4)', symbol: '4.MD', core: 'Measurement & Data'},
		{grade_id: 5, name: 'Geometry (Grade 4)', symbol: '4.G', core: 'Geometry'},
		{grade_id: 5, name: 'Fractions (Grade 4)', symbol: '4.NF', core: 'Number & Operations-Fractions'},
		{grade_id: 6, name: 'Math Operations & Algebra (Grade 5)', symbol: '5.OA', core: 'Operations & Algebraic Thinking'},
		{grade_id: 6, name: 'Numbers & Place Value (Grade 5)', symbol: '5.NBT', core: 'Number & Operations in Based Ten'},
		{grade_id: 6, name: 'Measurement & Data (Grade 5)', symbol: '5.MD', core: 'Measurement & Data'},
		{grade_id: 6, name: 'Geometry (Grade 5)', symbol: '5.G', core: 'Geometry'},
		{grade_id: 6, name: 'Fractions (Grade 5)', symbol: '5.NF', core: 'Number & Operations-Fractions'},
		{grade_id: 7, name: 'Ratios & Proportions (Grade 6)', symbol: '6.RP', core: 'Ratios & Proportional Relationships'},
		{grade_id: 7, name: 'Number System (Grade 6)', symbol: '6.NS', core: 'the Number System'},
		{grade_id: 7, name: 'Expressions & Equations (Grade 6)', symbol: '6.EE', core: 'Expressions & Equations'},
		{grade_id: 7, name: 'Geometry (Grade 6)', symbol: '6.G', core: 'Geometry'},
		{grade_id: 7, name: 'Statistics & Probability (Grade 6)', symbol: '6.SP', core: 'Statistics & Probability'},
		{grade_id: 8, name: 'Ratios & Proportions (Grade 7)', symbol: '7.RP', core: 'Ratios & Proportional Relationships'},
		{grade_id: 8, name: 'Number System (Grade 7)', symbol: '7.NS', core: 'the Number System'},
		{grade_id: 8, name: 'Expressions & Equations (Grade 7)', symbol: '7.EE', core: 'Expressions & Equations'},
		{grade_id: 8, name: 'Geometry (Grade 7)', symbol: '7.G', core: 'Geometry'},
		{grade_id: 8, name: 'Statistics & Probability (Grade 7)', symbol: '7.SP', core: 'Statistics & Probability'},
		{grade_id: 9, name: 'Number System (Grade 8)', symbol: '8.NS', core: 'the Number System'},
		{grade_id: 9, name: 'Expressions & Equations (Grade 8)', symbol: '8.EE', core: 'Expressions & Equations'},
		{grade_id: 9, name: 'Geometry (Grade 8)', symbol: '8.G', core: 'Geometry'},
		{grade_id: 9, name: 'Statistics & Probability (Grade 8)', symbol: '8.SP', core: 'Statistics & Probability'},
		{grade_id: 9, name: 'Functions (Grade 8)', symbol: '8.F', core: 'Functions'}
		])
end


	Standard.create([
		{grade_id: 1, domain_id: 1, symbol: 'CCSS.Math.Content.K.OA.A.1', short: 'K.OA.1',
			url: 'http://www.corestandards.org/Math/Content/K/OA/A/1',
			description: 'Represent addition and subtraction with objects, fingers, mental images, drawings2, sounds (e.g., claps), acting out situations, verbal explanations, expressions, or equations.',
			ICan: 'use objects, fingers and pictures to help me show addition and substraction.'},
		{grade_id: 1, domain_id: 1, symbol: 'CCSS.Math.Content.K.OA.A.2', short: 'K.OA.2',
			url: 'http://www.corestandards.org/Math/Content/K/OA/A/2',
			description: 'Solve addition and subtraction word problems, and add and subtract within 10.',
			ICan: 'solve addition and subtraction word problems within 10.'},
		{grade_id: 1, domain_id: 1, symbol: 'CCSS.Math.Content.K.OA.A.3', short: 'K.OA.3',
			url: 'http://www.corestandards.org/Math/Content/K/OA/A/3',
			description: 'Decompose numbers less than or equal to 10 into pairs in more than one way.',
			ICan: 'take apart numbers less than or equal to 10.'},
		{grade_id: 1, domain_id: 1, symbol: 'CCSS.Math.Content.K.OA.A.4', short: 'K.OA.4',
			url: 'http://www.corestandards.org/Math/Content/K/OA/A/4',
			description: 'For any number from 1 to 9, find the number that makes 10 when added to the given number.',
			ICan: 'find the number that is added to 1 through 9 to make 10.'},
		{grade_id: 1, domain_id: 1, symbol: 'CCSS.Math.Content.K.OA.A.5', short: 'K.OA.5',
			url: 'http://www.corestandards.org/Math/Content/K/OA/A/5',
			description: 'Fluently add and subtract within 5.',
			ICan: 'add and subtract within 5.'},
		{grade_id: 1, domain_id: 2, symbol: 'CCSS.Math.Content.K.NBT.A.1', short: 'K.NBT.1',
			url: 'http://www.corestandards.org/Math/Content/K/NBT/A/1',
			description: 'Compose and decompose numbers from 11 to 19 into ten ones and some further ones.',
			ICan: 'put together and take apart numbers from 11 to 19 by naming the tens and ones.'},
		{grade_id: 1, domain_id: 3, symbol: 'CCSS.Math.Content.K.MD.A.1', short: 'K.MD.1',
			url: 'http://www.corestandards.org/Math/Content/K/MD/A/1',
			description: 'Describe measurable attributes of objects, such as length or weight. Describe several measurable attributes of a single object.',
			ICan: 'tell how an object can be measured, e.g., by length, wideth, etc.'},
		{grade_id: 1, domain_id: 3, symbol: 'CCSS.Math.Content.K.MD.A.2', short: 'K.MD.2',
			url: 'http://www.corestandards.org/Math/Content/K/MD/A/2',
			description: 'Directly compare two objects with a measurable attribute in common, to see which object has more of or less of the attribute, and describe the difference.',
			ICan: 'compare how two objects are similar or different, e.g., more of, less of, taller, shorter, etc.'},
		{grade_id: 1, domain_id: 3, symbol: 'CCSS.Math.Content.K.MD.B.3', short: 'K.MD.3',
			url: 'http://www.corestandards.org/Math/Content/K/MD/B/3',
			description: 'Classify objects into given categories; count the numbers of objects in each category and sort the categories by count.',
			ICan: 'place objects into categories, count the number of objects in categories, and sort the categories by the number of objects.'},	
		{grade_id: 1, domain_id: 4, symbol: 'CCSS.Math.Content.K.G.A.1', short: 'K.G.1',
			url: 'http://www.corestandards.org/Math/Content/K/G/A/1',
			description: 'Describe objects in the environment using names of shapes, and describe the relative positions of these objects using terms such as above, below, beside, in front of, behind, and next to.',
			ICan: 'find shapes around me, tell where shapes are, tell about shapes, and compare shapes'},
		{grade_id: 1, domain_id: 4, symbol: 'CCSS.Math.Content.K.G.A.2', short: 'K.G.2',
			url: 'http://www.corestandards.org/Math/Content/K/G/A/2',
			description: 'Correctly name shapes regardless of their orientations or overall size..',
			ICan: 'name shapes'},
		{grade_id: 1, domain_id: 4, symbol: 'CCSS.Math.Content.K.G.A.3', short: 'K.G.3',
			url: 'http://www.corestandards.org/Math/Content/K/G/A/3',
			description: 'Identify shapes as two-dimensional (lying in a plane, or flat) or three-dimensional (solid).',
			ICan: 'tell flat shapes as two-dimensional and solid shapes as three-dimensional'},
		{grade_id: 1, domain_id: 4, symbol: 'CCSS.Math.Content.K.G.B.4', short: 'K.G.4',
			url: 'http://www.corestandards.org/Math/Content/K/G/B/4',
			description: 'Analyze and compare two- and three-dimensional shapes, in different sizes and orientations, using informal language to describe their similarities, differences, parts and other attributes.',
			ICan: 'compare two-dimensional and three-dimensional shapes'},
		{grade_id: 1, domain_id: 4, symbol: 'CCSS.Math.Content.K.G.B.5', short: 'K.G.5',
			url: 'http://www.corestandards.org/Math/Content/K/G/B/5',
			description: 'Model shapes in the world by building shapes from components (e.g., sticks and clay balls) and drawing shapes.',
			ICan: 'make shapes using materials like sticks and clay.'},
		{grade_id: 1, domain_id: 4, symbol: 'CCSS.Math.Content.K.G.B.5', short: 'K.G.5',
			url: 'http://www.corestandards.org/Math/Content/K/G/B/5',
			description: 'Model shapes in the world by building shapes from components (e.g., sticks and clay balls) and drawing shapes.',
			ICan: 'make shapes using materials like sticks and clay.'},
		{grade_id: 1, domain_id: 4, symbol: 'CCSS.Math.Content.K.G.B.6', short: 'K.G.6',
			url: 'http://www.corestandards.org/Math/Content/K/G/B/6',
			description: 'Compose simple shapes to form larger shapes.',
			ICan: 'use simple shapes to make larger shapes.'},	
		{grade_id: 2, domain_id: 6, symbol: '1.NBT.1', description: 'Count to 120, starting at any number less than 120.', ICan: 'count to 120' },
		{grade_id: 2, domain_id: 6, symbol: '1.NBT.2', description: 'Understand that the two digits of a two-digit number represent amounts of tens and ones.', ICan: 'tell how many tens and how many ones are in a number' }
	])

