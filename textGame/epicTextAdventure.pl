:-[tokenizer].
:-[write].
:-[grammar].

play :- resetWorld, write('Welcome!'), nl, inner_play, !, loop_thru_game.

loop_thru_game :- repeat, execute(C), do(C), ((C==quit; check_over), !).

execute(C) :- read_atomics(Sent), phrase(L,Sent,[]), C=..L, !.
execute(_) :- write('You be talkin crazy!'), nl, fail.

do(X) :- X, !.
quit :- write('I understand. Believe me I have been there, too...'), !.

check_over :- gameover(win), write('Amazing! You got it all done. A+'), !.
check_over :- gameover(lost), write('F-! You fail at life.').

resetWorld:- retract(here(_)).
