place(house).
place(bar).
place(lab).
place(jail).
place(library).

at(mom, house).
at(brother, house).
at(bartender, bar).
at(policeman, bar).
at(ta, lab).
at(jailer, jail).
at(prisoner, jail). %a random prisoner also in jail
at(kim, library).
at(librarian, library).

person(mom).
person(brother).
person(bartender).
person(policeman).
person(ta).
person(jailer).
person(prisoner).
person(kim).
person(librarian).

action(blackmail, lab).
action(blackmail, library).
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