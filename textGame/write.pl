
play:-
	insert_facts, % inserts initial data to the world
	write('Your goal as a CS student is to complete a project ans get an A+.'),nl,
	write('However, you will encounter many obstacles'),nl,
	write('in order to complete a project.'),nl,
	n,
	write('You can type "help" along the way if you need help on how to play'),nl,
	write('Good Luck!').

hint:-	
	write('Commands you can use to play the game:'),nl,
  	nl,
  	tab(1),write('go to a place         		(ex. go to the lab)'),nl,
  	tab(1),write('start a project				(ex. start schedular)'),nl,
  	tab(1),write('write code					(ex. write code'),nl,
  	tab(1),write('cry on someone\'s shoulder	(ex. cry on Kim\'s shoulder'),nl,
  	tab(1),write('punch someone					(ex. punch the bartender'),nl,
  	tab(1),write('seduce someone				(ex. seduce TA'),nl,
  	tab(1),write('blackmail someone				(ex. blackmail policeman'),nl,
  	tab(1),write('buy something					(ex. buy drink from bartender'),nl,
	nl,
  	write('Hit any key to continue.'),nl,
  	get0(_),
  	look.

% go_to(Place) moves the player to a new location
go_to(Place) :-
	retract(here(_)),
	asserta(here(Place)),
	look.
go_to(_) :- look.

% look lists the things in a room, and the connections
% assertz(here(StartLocation)) at the beginning.
% 
look:-
  	here(Here),
  	respond(['You are in the ',Here]),
  	write('You can go to the following places:'),nl,
  	list_connections(Here),
  	write('You can see the following people:'),nl,
  	list_people(Here).

list_people(Place):-
  	people(X,Place),
  	tab(2),write(X),nl,
  	fail.
list_people(_).

list_connections(Place):-
  	connect(Place,X),
  	tab(2),write(X),nl,
  	fail.
list_connections(jail):-
	write('You have no where to go. Wait until policeman lets you out.'),
	fail.
list_connections(_).

connect(X,Y):- path(X,Y).
connect(X,Y):- path(Y,X).

path(house,bar).
path(house,lab).
path(bar,lab).