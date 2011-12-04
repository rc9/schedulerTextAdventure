:-[tokenizer], [write], [grammar].

play :- write('Welcome!'), nl, inner_play, !, loop_thru_game.
loop_thru_game :- repeat, check_over, read_atomics(Sent), phrase(C,O,Sent,[]), C=..O, do(C), fail.

check_over :- check_won, !.
check_over :- check_lost.


