:- [world].

inner_play:-
	dynamic_facts, % inserts initial data to the world
	write('Your goal as a CS student is to complete a Prolog project and get an A+.'),nl,
	write('However, you will encounter many obstacles'),nl,
	write('in order to complete this project.'),nl,
	nl,
	write('You can type "help" along the way if you need help on how to play.'),nl,
	write('Good Luck!'),nl,
	look.

help:-	
	write('Commands you can use the following to play the game:'),nl,
  	nl,
  	tab(2),write('go to a place         (ex. go to the lab)'),nl,
  	tab(2),write('choose a project		(ex. choose schedular)'),nl,
  	tab(2),write('write code			(ex. write code'),nl,
  	tab(2),write('cry to someone		(ex. cry to Kim'),nl,
  	tab(2),write('punch someone			(ex. punch the bartender'),nl,
  	tab(2),write('seduce someone		(ex. seduce the TA'),nl,
  	tab(2),write('blackmail someone		(ex. blackmail the policeman'),nl,
  	tab(2),write('drink something		(ex. drink some beer'),nl,
  	tab(2),write('bribe someone			(ex. bribe the jailer)'), nl,
	nl,
  	write('Hit any key to continue.'),nl,
  	get0(_),
  	look.

% go(+Place) moves the player to a new location
go(Place) :-
	retract(here(_)),
	asserta(here(Place)),!,
	look.
go(_) :- look.

% punch(+Person) punches someone in the location
% and results in a policeman to put you in a jail.
punch(Person) :-
	isHere(Person),
	write('Uhoh you are in trouble now... The policeman dragged you off to jail.'), nl,
	retract(here(_)),
	asserta(here(jail)),
	look.
punch(_).

% bribe(+Person) you\'re trying to bribe someone to get easy shortcut.
bribe(jailer) :-
	isHere(jailer),
	write('I can\'t believe you deciede to bribe the jailer...'),nl,
	write('Oh well...so now you\'re back home. What are you gonna do?'),nl,
	go(house).
bribe(Person) :-
	isHere(Person),
	writeSen(['You got a suspicious dirty look from ',Person,'...']).
bribe(_).
	
% seduce(+Person) you're trying to seduce someone to get out of trouble.
seduce('TA'):-
	isHere('TA'),
	write('what a corrupted TA... he gave you advice about how to tokenize input'),nl,
	store_advice(toTokenizeInput).
seduce(Person):-
	isHere(Person),
	write('You\'re not gonna get any work done tonight...'),nl.
seduce(_).

%cry(+Person) You\'re about to cry on someone's shoulder..
cry(jailer):-
	isHere(jailer),
	write('You cried to the jailer and with pity he advises you to swtich your project.'), nl,
	write('Hm...The jailer doesn\'t seem to enjoy his job. Maybe he\'ll take a bribe.'), nl,
	store_advice(toSwitchProject).
cry(Person) :-
	isHere(Person),
	writeSen(['Awwwww ',Person, ' let you borrow a shoulder to cry on.']),
	write('You are comforted'),nl.
cry(_).

% drink(+Bevarage): buying a bevarage buy talking to a bartender
drink(_):-
	( here(bar) -> write('Guess what?'),nl,
	write('The bartender just taught you how to change the xml output line to an epoch timestamp in prolog!! '), nl,
	write('What a smart bartender.'),nl,
	store_advice(toChangeXMLToTimestamp);
	write('You can drink only at the bar'),nl).

% look lists the things in a room, and the connections
% assertz(here(StartLocation)) at the beginning.
look:-
  	here(Here),
  	writeSen(['You are at the ',Here]),
  	write('You can see the following people:'),nl,
  	list_peopleAt(Here),
  	write('You can go to the following places:'),nl,
  	list_connections(Here).

list_peopleAt(Place):-
  	at(X,Place),
  	tab(2),write(X),nl,
  	fail.
list_peopleAt(_).

list_connections(Place):-
  	connect(Place,X),
  	tab(2),write(X),nl,
  	fail.
list_connections(jail):-
	tab(2), write('You have no where to go. Try talking to some people.'),nl.
list_connections(_).

connect(X,Y):- path(X,Y).
connect(X,Y):- path(Y,X).

path(house,bar).
path(house,lab).
path(bar,lab).
