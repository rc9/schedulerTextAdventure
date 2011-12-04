inputToTimeStamp(UserInput, FromTime, ToTime):- 
	split_string(UserInput, UserInputList),
	inputToDates(InputList, FromDate, ToDate),
	date_time_stamp(FromDate, FromTime),
	date_time_stamp(ToDate, ToTime).
	
inputToDates(InputList, FromDate, ToDate) :-
		

%Returns the element at the given index.
elementAtIndex(0,[X|Xs],X).
elementAtIndex(Index, [First|Rest], Element) :-
	Index1 is Index-1,
	elementAtIndex(Index1, Rest, Element).
	
	
% Takes in an input, changes it to a proper format which it can split,
% split the string to words, 
split_string(Input,Output) :-
	toProperFormat(Input, LCInput),
	string_tokens(LCInput," " ,SplitedString),
	codeListToChars(SplitedString, Output).

%Changes character codes to corresponding Char value.
codeListToChars([],[]) :- !.
codeListToChars([H|T],[X|Xs]) :- 
	read_from_chars(H,X),
	codeListToChars(T,Xs).
	
% toProperFormat changes a upper case letters to lower case
% and changes ':' to ' ' so that it will split hour and minute.
toProperFormat([],[]).
toProperFormat([H|T],[H1|T1]) :- 
	H =:= 58, !, H1 is H-26, toProperFormat(T,T1).
toProperFormat([H|T],[H1|T1]) :- 
	65 =< H, H =< 90, !, H1 is H + 32, toProperFormat(T,T1).
toProperFormat([H1|T],[H1|T1]) :- toProperFormat(T,T1).

% tokenizer which caller can pass in a string as a predicate.
% From below is from the web. referece is in the readme file.
string_tokens(Cs, StpS, Ts) :- phrase(tokens(Cs, StpS, []), Ts).

tokens([], _, Ts) --> token(Ts).
tokens([C|Cs], StpS, Ts) -->
( { memberchk(C,StpS) } -> token(Ts), tokens(Cs, StpS, [])
; tokens(Cs, StpS, [C|Ts])).

token([]) --> [].
token([T|Ts]) --> { reverse([T|Ts], Token) }, [Token].
