:-[tokenizer].
:-[write].
:-[grammar].

play :- write('Welcome!'), nl, inner_play, !, loop_thru_game.
loop_thru_game :- repeat, read_atomics(Sent), phrase(L,Sent,[]), C=..L, write(C), nl, do(C), ((check_over; L==[quit]), !).

do(X) :- X, !.
quit :- write('I understand. Believe me I have been there, too...'), !.

check_over :- check_won, !.
check_over :- check_lost.

% need some conditions.
check_won :- fail.
check_lost :- fail.


