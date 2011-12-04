place(house).
place(bar).
place(lab).
place(jail).

at(mom, house).
at(brother, house).
at(bartender, bar).
at(policeman, bar).
at(ta, lab).
at(jailer, jail).
at(kim, lab).

person(mom).
person(brother).
person(bartender).
person(policeman).
person(ta).
person(jailer).
person(kim).

action(blackmail, lab).
action(blackmail, bar).
action(code, house).
action(cry, _).
action(drink, bar).
action(punch, _).
action(seduce, _). %seduction can happen anywhere ;)


% this needs to run at the start of the program
dynamic_facts:-
	assertz(here(house)),
	assertz(advice(base)), % you are given base advice to start (it helps queries to have the predict always exist)
	assertz(gameover(no)).

%----actions-------

% goto(+Place)
% moves your character to Place 
% and updates KB
goto(Place) :-
	retract(here(_)),
	asserta(here(Place)).
	
% store_advice(+Advice)
% stores a piece of advice in the KB
store_advice(Advice) :-
	not(advice(Advice)), % ensure we don't already have this in KB
	asserta(advice(Advice)).
	
blackmail(kim) :-
	%TODO add humor and wit
	isHere(kim),
	writeSen(['You are about to blackmail ', kim]),
	Advice='Madness takes its toll. Please have exact change.', % http://www.mtholyoke.edu/~emdurso/amusing.html
	store_advice(toImportXML),
	writeSen(['Kim has given you some great advice: ', Advice]),
	writeSen(['This advice has given you some insight into importing XML files! Sweet!']).
	
% fall through in case blackmailing fails
blackmail(Person) :-
	writeSen(['You can\'t blackmail ', Person]).

% the case where you have all the advice you need
write_code :-
	advice(toImportXML),
	advice(toTokenizeInput),
	advice(toChangeXMLToTimestamp),
	advice(toSwitchProject),
	writeSen('OMFG you have all the pieces to the puzzle! The answer was right infront of your face the entire time!'),
	writeSen('All you had to do was make a mediocre text adventure game! Who knew???'),
	writeSen('So much easier! Prolog for the win!'),
	retract(gameover(_)),
	asserta(gameover(win)).

% still missing some advice
write_code :-
	writeSen(['Hmmm. You\'re not making progress and you can\'t quite figure out what\'s wrong. Maybe you need some inspiration from someone else...']).
	

% writeSen(List) writes out the list into a string.
writeSen([]) :- write('.'), nl.
writeSen([H|T]) :- write(H), writeSen(T).

% isHere(+Person) checks if the person the user requested
% is in the current location.
isHere(Person) :-
	here(Here),
	at(Person, Here), !.
isHere(Person) :-
	writeSen([Person, ' is not here']),
	fail.