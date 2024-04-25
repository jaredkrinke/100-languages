REBOL [
      Title: "Project Euler Problem 31"
      Version: 1.0.0
      Author: "Jared Krinke"
]

coin-values: [200 100 50 20 10 5 2 1]
count: 0

recurse: func [values target] [
	case [
		(target < 0) []
		(target = 0) [count: count + 1]
		true [
			foreach value values [
				/local t: target - value
				if (t >= 0) [
					recurse (find values value) t
				]
			]
		]
	]
]

recurse coin-values 200
print count
