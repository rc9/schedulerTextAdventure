


% look lists the things in a room, and the connections
% assertz(here(StartLocation)) at the beginning.
% 
look:-
  	here(Here),
  	respond(['You are in the ',Here]),
  	write('You can see the following people:'),nl,
  	list_things(Here),
  	write('You can do:'),nl,
  	list_actions(Here),
  	write('You can go to the following rooms:'),nl,
  	list_connections(Here).

list_people(Place):-
  	people(X,Place),
  	tab(2),write(X),nl,
  	fail.
list_people(_).
	
list_actions(Place:):-
	action(X,Place),
	tab(2), write(X), nl,
	fail.
list_actions(_).

list_connections(Place):-
  	connect(Place,X),
  	tab(2),write(X),nl,
  	fail.
list_connections(_).