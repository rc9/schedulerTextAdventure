%%%% WORLD FILE %%%%

%% Implicit Knowledge %%
place(house).
place(bar).
place(lab).
place(jail).

at(mom, house).
at(brother, house).
at(bartender, bar).
at(policeman, bar).
at('TA', lab).
at('Kim', lab).
at(jailer, jail).
at(prisoner, jail).

person(mom).
person(brother).
person(bartender).
person(policeman).
person('TA').
person(jailer).
person('Kim').
person(prisoner).

thing(money).
thing(iPhone).
thing('fake ID').
thing(drink).
thing(flowers).

action(blackmail, lab).
action(blackmail, bar).
action(blackmail, house).
action(code, house).
action(cry, _).
action(drink, bar).
action(punch, _).
action(seduce, _). %seduction can happen anywhere ;)

path(house,bar).
path(house,lab).
path(bar,lab).

toImportXML :- 'how to import XML documents into prolog'.
toChangeXMLToTimestamp :- 'how to change dates from the XML into prolog timestamps'.
toTokenizeInput :- 'how to interpret all allowable sentences for querying <who> can meet <when>'.
toSwitchProject :- 'that doing a prolog scheduler is way too time consuming right before finals, but there is hope it will be done in the future!'.

% knowledge added when program starts that may be altered
dynamic_facts:-
	assertz(here(house)),
%	assertz(advice('nothing else')), % you are given base advice to start (it helps queries to have the predict always exist)
	assertz(gameover(no)),
	assertz(things(money, house)),
	assertz(things(iPhone, bar)),
	assertz(things('fake ID', lab)),
	assertz(things(flowers, house)),
    assertz(prisonerhasmoney).

%% Actions %%
	
% store_advice(+Advice)
% stores a piece of advice in the KB
store_advice(Advice) :-
	not(advice(Advice)), % ensure we don't already have this in KB
	asserta(advice(Advice)).	

% writeSen(+List)
% writes out the list into a string.
writeSen([]) :- write('.'), nl.
writeSen([H|T]) :- write(H), writeSen(T).

% isHere(+Person)
% checks if the person the user requested is in the current location.
isHere(Person) :-
	here(Here),
	at(Person, Here), !.
isHere(Person) :-
	writeSen([Person, ' is not here']),
	fail.

% use(+Thing)
% uses an item
use(Thing) :- 
	possession(Thing),
	here(Here),
	retract(possession(Thing)),
	writeSen(['You used the ', Thing, ' at the ', Here, '. I hope you know what you\'re doing...']).

% go(+Place, +Object)
%
go(Place, Object):-
    possession(Object), go(Place).
go(Place, Object) :-
    writeSen(['You don\'t have ', Object, ' but you are still going.']), 
    go(Place).


% go(+Place)
% moves the player to a new location
go(Place) :-
	( here(jail) -> write('You can\'t just LEAVE jail!'),nl, fail; 
	retract(here(_)),
	asserta(here(Place)),!,
	look).
go(_).

% where
% print current location
where :- look.
% punch(+Person, +Object) 
% using an object for action punch is not necessary.
punch(Person,Object) :- 
writeSen(['You don\'t need to use ', Object, ' to punch...']), punch(Person).

% punch(+Person)
% punch the stranger in jail to get his money
punch(prisoner) :-
here(jail), !, ( prisonerhasmoney -> 
    write('You just stole all your cell mate\'s money. Maybe you deserve to be in jail...'),nl, 
    assertz(possession(money)), retract(prisonerhasmoney); 
    write('You already took the poor prisoner\'s money! Leave him alone!'),nl).

% punched someone in the location and results in a policeman putting you in jail
punch(Person) :-
	(here(jail) -> write('You\'re locked in jail! How can you punch but prisoners?.'),nl; isHere(Person),
	write('Uhoh you\'re in trouble now... The policeman dragged you off to jail.'), nl,
    write('There\'s a bored jailer ensuring you can\'t escape. '),
    write('Your instincts tell you he might be sympathetic to your plight...'),nl,
	go(jail)).
punch(_).

% bribe(+Person, +Object)
% check if the object passed in is money
bribe(Person, money) :- bribe(Person).
bribe(_,Object) :- writeSen(['You can\'t bribe with ', Object]).

% bribe(+Person)
% try to bribe someone to get an easy shortcut
bribe(jailer) :-
	isHere(jailer),
	( use(money) ->
	write('I can\'t believe you decided to bribe the jailer...'),nl,
	write('Oh well...so now you\'re back home. What are you gonna do?'),nl,
    retract(here(_)),asserta(here(house)),!,look; 
    write('You have no money! And now the jailer will never let you out. Looks like you\'ll be in jail for a while.')
	,nl, write('...'), nl,
	write('Finally your mom came and rescued you. She does NOT look happy.'),nl,
	write('On top of all that you missed the project deadline!'), nl,
	retract(gameover(_)),
	assert(gameover(lost))).
bribe(Person) :-
	isHere(Person),
	use(money),
	writeSen(['You got a suspicious dirty look from ',Person,'...']).
bribe(Person) :-
	isHere(Person),
	write('Your bribe attempt was unsuccessful...do you even have what you\'re offerring?'),nl.
bribe(_).

% seduce(+Person, +Object) 
% check if the object passed in is a flower
seduce(Person, flowers) :- seduce(Person).
seduce(_,Object) :- writeSen(['You can\'t seduce with ', Object]).
	      
% seduce(+Person)
% try to seduce someone to get out of trouble
seduce('TA'):-
	isHere('TA'),
	use(flowers),
	write('what a corrupted TA... he gave you advice about how to tokenize input'),nl,
	store_advice('tokenize user input').
seduce(Person):- 
	isHere(Person),
	use(flowers),
	write('You\'re not gonna get any work done tonight...'),nl.
seduce(Person) :-
	isHere(Person),
	write('You just got shutdown! Maybe you should look for something to help you with this...'), nl.
seduce(_).

% cry(+Person, +Object) 
% using an object for action cry is not necessary.
cry(Person,Object) :- 
    writeSen(['You don\'t need to use ', Object, ' to cry...']), cry(Person).

% cry(+Person)
% cry on someone's shoulder
cry(jailer):-
	isHere(jailer),
	write('You cried to the jailer and with pity he advises you to swtich your project.'), nl,
	write('Hm...The jailer doesn\'t seem to enjoy his job. Maybe he\'ll take a bribe.'), nl,
	store_advice('switch a project').
cry(Person) :-
	Person \= jailer,
	isHere(Person),
	writeSen(['Awwwww ',Person, ' let you borrow a shoulder to cry on.']),
	write('You are comforted'),nl.
cry(_).

% drink(+Person, +Object) 
% check if the object passed in is the ID
drink(Person, 'fake ID') :- drink(Person).
drink(_,Object) :- writeSen(['You can\'t drink with ', Object]).

% drink(+Bevarage):
% buy a bevarage by talking to a bartender
drink(drink):-
	( here(bar) -> use('fake ID'), write('Guess what?'),nl,
	write('The bartender just taught you how to change the xml output line to an epoch timestamp in prolog!'), nl,
	write('What a smart bartender.'),nl,
	write('He also realized you used a fake ID, so he took it. Better not try that again...'),nl,
	store_advice('change XML info to prolog timestamp');
	write('You can only drink at the bar'),nl).
drink(drink) :-
	writeSen(['The bartender needs to see some id before you can have your drink']).
drink(Object) :- 
    writeSen(['You can\'t drink the ', Object]).

% blackmail(+Person, +Object) 
% check if the object passed in is a iPhone
blackmail(Person, iPhone) :- blackmail(Person).
blackmail(_,Object) :- writeSen(['You can\'t blackmail with ', Object]).

% blackmail(+Person)
% attempt to blackmail someone to get what you need
blackmail('Kim') :-
	isHere('Kim'),
	( store_advice('import XML file in prolog') ->
	  %then
	use(iPhone),
	write('Kim is so grateful you found her iPhone.'),nl,
	write('But what?! You think she\'ll succumb to embarrassing photos?'), nl,
	write('HA! She instantly sends them to the cloud, no shame in her eyes.'), nl,
	write('But because she is so awesome and knows how much you are struggling with this extra difficult problem she decides to give you some advice so long as you never blackmail her again.'),nl,
	writeSen(['This advice has given you some insight into importing XML files! Sweet!']);
	  %else
	write('You disappointed Kim.  Trying to blackmail her again, honestly...'),nl,
	retract(gameover(_)), assert(gameover(lost))).
	
% fall through in case blackmailing fails
blackmail(Person) :-
	isHere(Person),
	writeSen(['You can\'t blackmail ', Person, '. You don\'t have any dirt to blackmail with!']).

% you can't write code while in jail or the bar
write_code:-
    (here(jail);here(bar)), write('You can\'t write code here!'), nl.

% the case where you have all the advice you need
write_code :-
	advice('import XML file in prolog'),
	advice('tokenize user input'),
	advice('change XML info to prolog timestamp'),
	advice('switch a project'),
	writeSen(['OMFG you have all the pieces to the puzzle! The answer was right infront of your face the entire time!']),
	writeSen(['All you had to do was make a amazing text adventure game! Who knew???']),
	writeSen(['So much easier! Prolog for the win!']),
	retract(gameover(_)),
	assert(gameover(win)).

% still missing some advice
write_code :-
	writeSen(['Hmmm. You\'re not making progress and you can\'t quite figure out what\'s wrong. Maybe you need some inspiration from someone else...']).

% pickUp(+Object)
% pick up an object
pickUp(iPhone) :-
	add_if_here(iPhone),
	writeSen(['You pick up the iPhone and take a peek at the contents. Oh my, there are pictures of Kim on here! Very embarassing pictures... Hmmmm. This might come in handy..']).
pickUp(money) :-
	add_if_here(money),
	writeSen(['You grabbed the moolah and are ready to rock! Make it rain!']).
pickUp('fake ID') :-
	add_if_here('fake ID'),
	writeSen(['Alright a fake ID! Go get \'em McLovin...']).
pickUp(Object):-
	Object \= money, Object \= 'fake ID', Object \= iPhone,
	isObjectHere(Object), 
	retract(things(Object,_)),
	asserta(possession(Object)), !,
	writeSen(['You picked up the ', Object]).

% add_if_here(+Object)
% checks whether item can be picked up and does so if possible
add_if_here(Object) :- 
	isObjectHere(Object), 
	retract(things(Object,_)),
	asserta(possession(Object)), !.

% drop(+Object)
% remove item from the inventory and leave it at current location
drop(Object):-
	here(Here),
	possession(Object),
	retract(possession(Object)),
	asserta(things(Object,Here)), !,
	writeSen(['You left the ',Object,' at the ', Here]).
drop(_) :- write('You can\'t drop what you don\'t have.'),nl.
	
% isObjectHere(+Object) checks if the object the user requested
% is in the current location.
isObjectHere(Object) :-
	here(Here),
	things(Object, Here), !.
isObjectHere(Object) :- writeSen(['No ', Object, ' to be found here']), fail.

% look lists the things in a room, and the connections
% assertz(here(StartLocation)) at the beginning.
look:-
  	here(Here),
  	writeSen(['You are at the ',Here]),
  	write('You see the following objects:'), nl,
  	list_things(Here),
  	write('You can see the following people:'),nl,
  	list_peopleAt(Here),
  	write('You can go to the following places:'),nl,
  	list_connections(Here).

% list_things(+Place)
% helper predicate to print out all the items to interact with
list_things(Place) :-
	things(X,Place),
	tab(3), write(X), nl,
	fail.
list_things(_).

% list_peopleAt(+Place)
% helper predicate to print out all people
list_peopleAt(Place):-
  	at(X,Place),
  	tab(3),write(X),nl,
  	fail.
list_peopleAt(_).

% list_connections(+Place)
% helper predicate to print out all connections
list_connections(Place):-
  	connect(Place,X),
  	tab(3),write(X),nl,
  	fail.
list_connections(jail):-
	tab(2), write('You have no where to go. Try interacting with someone.'),nl.
list_connections(_).

% get your knowledge (advice acquired)
knowledge:-
	write('You currently know how to:'), nl,
  	list_knowledge.

% helper method to print out all knowledge
list_knowledge :-
	advice(X), tab(3), write(X), nl, fail.
list_knowledge.

% get all the items that you currently have
inventory:-
	write('You currently have:'), nl,
	list_possession.

% helper predicate to print out all possessions
list_possession :-
	possession(X), tab(3), write(X), nl, fail.
list_possession.
	

% connect(-Location1, -Location2)
% get which locations can access which
connect(X,Y):- path(X,Y).
connect(X,Y):- path(Y,X).
