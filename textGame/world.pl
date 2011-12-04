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

dynamic_facts:-
	assertz(here(house)).

%actions

% goto(+Place)
% moves your character to Place 
% and updates KB
goto(Place) :-
	retract(here(_)),
	asserta(here(Place)).