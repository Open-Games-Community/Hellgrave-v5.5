-- Minlevel and multiplier are MANDATORY
-- Maxlevel is OPTIONAL, but is considered infinite by default
-- Create a stage with minlevel 1 and no maxlevel to disable stages

-- HELLGRAVE RPG was tested for start from 150x and decreasing, level 100 - x50, 200 x25 , 300 x18 ( Before 200x to level 300 x 10 ), 400 x12, 500+ x6.
-- You can adjust your own rate stages.

-- Important: Loot was tested x2 and not x3, x3 is to higher for a low custom RPG server! Remember before start your server, if you set x3 everyone become rich very fast.
experienceStages = {
	{
		minlevel = 1,
		maxlevel = 10,
		multiplier = 100
	}, {
		minlevel = 10,
		maxlevel = 50,
		multiplier = 400
	}, {
		minlevel = 51,
		maxlevel = 100,
		multiplier = 350
	}, {
		minlevel = 101,
		maxlevel = 150,
		multiplier = 300
	}, {
		minlevel = 151,
		maxlevel = 200,
		multiplier = 250
	},{
		minlevel = 201,
		maxlevel = 250,
		multiplier = 200
	},{
		minlevel = 251,
		maxlevel = 300,
		multiplier = 150
	},{
		minlevel = 301,
		maxlevel = 450,
		multiplier = 100
	}, {
		minlevel = 451,
		maxlevel = 550,
		multiplier = 80
	},{
		minlevel = 551,
		maxlevel = 650,
		multiplier = 70
	},{
		minlevel = 651,
		multiplier = 50
	}
}

skillsStages = {
	{
		minlevel = 10,
		maxlevel = 60,
		multiplier = 25
	}, {
		minlevel = 61,
		maxlevel = 80,
		multiplier = 17
	}, {
		minlevel = 81,
		maxlevel = 110,
		multiplier = 10
	}, {
		minlevel = 111,
		maxlevel = 125,
		multiplier = 6
	}, {
		minlevel = 126,
		multiplier = 3
	}
}

magicLevelStages = {
	{
		minlevel = 0,
		maxlevel = 60,
		multiplier = 16
	}, {
		minlevel = 61,
		maxlevel = 80,
		multiplier = 14
	}, {
		minlevel = 81,
		maxlevel = 100,
		multiplier = 12
	}, {
		minlevel = 101,
		maxlevel = 110,
		multiplier = 10
	}, {
		minlevel = 111,
		maxlevel = 125,
		multiplier = 6
	}, {
		minlevel = 126,
		multiplier = 4
	}
}
