

split_string(Input,Seperator,Output) :-
	toLowerCase(Input, LCInput),
	string_tokens(LCInput, Seperator, SplitedString),
	codeListToChars(SplitedString, Output).

string_tokens(Cs, StpS, Ts) :- phrase(tokens(Cs, StpS, []), Ts).

tokens([], _, Ts) --> token(Ts).
tokens([C|Cs], StpS, Ts) -->
( { memberchk(C,StpS) } -> token(Ts), tokens(Cs, StpS, [])
; tokens(Cs, StpS, [C|Ts])).

token([]) --> [].
token([T|Ts]) --> { reverse([T|Ts], Token) }, [Token].

codeListToChars([],[]) :- !.
codeListToChars([H|T],[X|Xs]) :- 
	read_from_chars(H,X),
	codeListToChars(T,Xs).
	
toLowerCase([],[]).
toLowerCase([H|T],[H1|T1]) :- 
	65 =< H, H =< 90, !, H1 is H + 32, toLowerCase(T,T1).
toLowerCase([H1|T],[H1|T1]) :- toLowerCase(T,T1).