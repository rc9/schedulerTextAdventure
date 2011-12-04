:- dynamic name/1, day/1, busy/3, free/3.
:-[tokenizer].
:-[grammar].

%% Interacting with user input.

test :- write('start'), nl, getUserTest.
getUserTest :- write('enter'), nl, read_atomics(Sen), write(Sen). %(Sen = [end], !; s(Sen,[]), write('yes'), nl, fail).

%Begin scheduler (using play since it is required by assignment).
	
play :- write('Welcome to your personal scheduler.  When interfacing, please ensure all input is in lowercase letters.'), nl, repeat, getInput.

prompt2 :- !, write('You can:'), nl, write('  enter a name you want to participate in the schedule (format: <name> RETURN)'), nl, write('  enter a participant\'s availability (include a name, availability, time)'''), nl, write('  get available times of a participant (end with ?)'), nl.

prompt :- !, write('How can I help you?'), nl, write('Please (remember lowercase) do not use commas and include an "and" between ALL names specified.'), nl.
%getInput :- prompt, read_atomics(Name),  (Name = [stop], ! ; insertName(Name)).
getInput :- prompt, read_atomics(Sentence), write(Sentence), nl, (Sentence =[end], !; (s(Sentence,[?]); s(Sentence, [])), !, write('yes'),nl, fail; write('no'), nl, fail).

insertName(X) :- !, assert(name(X)), write(X), write('  added.'), nl.



%% Parsing grammar
/*
 SEPARATE FILE 
  
s --> np(Num), vp(Num).
np(Num) --> d, noun_with_count(Num).
vp(Num) --> verb_with_count(Num), np(_).

verb_with_count(plural) --> vs.
verb_with_count(singular) --> v.

noun_with_count(plural) --> ns.
noun_with_count(singular) --> n.

n --> [name(riley)];[name(hanna)];[day(monday)].
ns --> [mondays];[days]; [weeks].

d --> [the];[a];[].


vs --> ['are busy'].
% v('am busy').
v --> ['is busy'].
*/


%% KB of individual's availability.
name([riley]).
name([hanna]).

%% Schedule blocks set at 30 minute intervals.