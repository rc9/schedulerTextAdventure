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
	assertz(advice(base)). % you are given base advice to start (it helps queries to have the predict always exist)

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