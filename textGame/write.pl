:- [world].

% sets up the game world and prints out some instructions
inner_play:-
	dynamic_facts, % inserts initial data to the world
	write('Your goal as a CS student is to complete a Prolog project and get an A+.'),nl,
	write('However, you will encounter many obstacles'),nl,
	write('in order to complete this project.'),nl,
	nl,
	write('You can type "help" along the way if you need help on how to play.'),nl,
	write('Good Luck!'),nl,
	look.

% displays possible commands
help:-	
	write('Commands you can use the following to play the game:'),nl,nl,
  	tab(2),write('go to a place		(ex. go to the lab)'),nl,
  	tab(2),write('choose a project		(ex. choose schedular)'),nl,
  	tab(2),write('write code		(ex. write code'),nl,
  	tab(2),write('cry to someone		(ex. cry to Kim'),nl,
  	tab(2),write('punch someone		(ex. punch the bartender'),nl,
  	tab(2),write('seduce someone		(ex. seduce the TA'),nl,
  	tab(2),write('blackmail someone		(ex. blackmail the policeman'),nl,
  	tab(2),write('drink something		(ex. drink some beer'),nl,
  	tab(2),write('bribe someone		(ex. bribe the jailer)'), nl,
	tab(2),write('pick up something		(ex. pick up the phone)'), nl,
	tab(2),write('drop something		(ex. drop the money)'), nl,
	tab(2),write('inventory			displays all items you have'), nl,
	tab(2),write('knowledge			displays all advice you collected'), nl,
	tab(2),write('where			relists your location and options'), nl,
	nl,
  	write('Hit any key to continue.'),nl,
  	get0(_),
  	look.