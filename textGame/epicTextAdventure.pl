%%%% TEXT ADVENTURE FILE %%%%

:-[tokenizer].
:-[grammar].

% begin the most epic text adventure game ever!
play :- write('Welcome to the EPIC text adventure game!'), nl, setup, !, loop_thru_game.

% continue playing the game until it is over or user quits
loop_thru_game :- repeat, make_command(C), do(C), ((C==quit; check_over), !).

% make_command(-Command)
% read in user input to create a command
make_command(C) :- read_atomics(Sent), phrase(L,Sent,[]), C=..L, !.
make_command(_) :- write('You be talkin crazy!'), nl, fail.

% do(+Command)
% execute newly created command from input
do(X) :- X, !.

% quick exit from game
quit :- write('I understand. Believe me I have been there, too...'), !.

% check if the game is over
check_over :- gameover(win), write('Amazing! You got it all done. A+'), !.
check_over :- gameover(lost), write('F-! You fail at life.').

% revert back to the start world state
resetWorld:- repeat, (retract(here(_)) -> fail;not(fail)), repeat, (retract(things(_,_)) -> fail;not(fail)), repeat, (retract(gameover(_)) -> fail;not(fail)), repeat, (retract(advice(_)) -> fail;not(fail)), repeat, (retract(possession(_)) -> fail;not(fail)).

% sets up the game world and prints out some instructions
setup :-
	resetWorld,
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