:- [tokenizer].


string_tokens(Cs, StpS, Ts) :- phrase(tokens(Cs, StpS, []), Ts).

tokens([], _, Ts) --> token(Ts).
tokens([C|Cs], StpS, Ts) -->
( { memberchk(C,StpS) } -> token(Ts), tokens(Cs, StpS, [])
; tokens(Cs, StpS, [C|Ts])).

token([]) --> [].
token([T|Ts]) --> { reverse([T|Ts], Token) }, [Token].
