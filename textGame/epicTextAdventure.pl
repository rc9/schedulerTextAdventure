:-[tokenizer].
:-[write].
:-[grammar].

play :- write('Welcome!'), nl, !, loop_thru_game.
loop_thru_game :- repeat, read_atomics(Sent), phrase(L,Sent,[]), write(L), nl, C=..L, write(C), nl, do(C), (check_over; C==quit).

do(X) :- X, !.

check_over :- check_won, !.
check_over :- check_lost.

% need some conditions.
check_won :- fail.
check_lost :- fail.


