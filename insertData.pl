inputToTimeStamp(UserInput, FromTime, ToTime):- 
	split_string(UserInput, UserInputList), length(UserInputList, L),
	inputToTimes(L, UserInputList, FromTime, ToTime).
	
%monList [jan, feb, mar, apr, may, jun, jul, aug, sep, oct, nov, dec].

inputToTimes(9, InputList, FromTime, ToTime) :-
	elementAtIndex(8,InputList,ToMin),
	elementAtIndex(3,InputList,Year),
	elementAtIndex(2,InputList,Month), monToNum(Month, MonthInNum), %elementIndex(Month, monList, MonthInNum),
	elementAtIndex(1,InputList,Date),
	elementAtIndex(4,InputList,FromHour),
	elementAtIndex(5,InputList,FromMin),
	elementAtIndex(7,InputList,ToHour),!,
	inputToDateForm(Year, MonthInNum, Date, FromHour, FromMin, FromTime),
	inputToDateForm(Year, MonthInNum, Date, ToHour, ToMin, ToTime).
	
inputToTimes(13, InputList, FromTime, ToTime) :-
	elementAtIndex(13,InputList ToMin),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
	elementAtIndex(3,InputList,Year),
	elementAtIndex(2,InputList,Month), monToNum(Month, MonthInNum), %elementIndex(Month, monList, MonthInNum),
	elementAtIndex(1,InputList,Date),
	elementAtIndex(4,InputList,FromHour),
	elementAtIndex(5,InputList,FromMin),!,
	inputToDateForm(Year, MonthInNum, Date, FromHour, FromMin, FromTime),
	inputToDateForm(Year, MonthInNum, Date, ToHour, ToMin, ToTime).
	
inputToDateForm(Year, Month, Date, Hour, Min, Time):-
	date_time_stamp(date(Year,Month,Date,Hour,Min,0,0,-,-), Time).
	
elementIndex(X, [X|Xs], 0) :- !.
elementIndex(X, [Y|Xs], Index) :- 
	elementIndex(X,Xs, Index1), !,
	Index is Index1+1.

%Returns the element at the given index.
elementAtIndex(0,[X|Xs],X).
elementAtIndex(Index, [First|Rest], Element) :-
	Index1 is Index-1,
	elementAtIndex(Index1, Rest, Element).
	
	
% Takes in an input, changes it to a proper format which it can split,
% split the string to words, 
split_string(Input,Output) :-
	toProperFormat(Input, LCInput),
	string_tokens(LCInput," ",SplitedString),
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

%To change the month from enlish word to a number.
monToNum(jan,1).
monToNum(feb,2).
monToNum(mar,3).
monToNum(apr,4).
monToNum(may,5).
monToNum(jun,6).
monToNum(jul,7).
monToNum(aug,8).
monToNum(sep,9).
monToNum(oct,10).
monToNum(nov,11).
monToNum(dec,12).


% tokenizer which caller can pass in a string as a predicate.
% From below is from the web. referece is in the readme file.
string_tokens(Cs, StpS, Ts) :- phrase(tokens(Cs, StpS, []), Ts).

tokens([], _, Ts) --> token(Ts).
tokens([C|Cs], StpS, Ts) -->
( { memberchk(C,StpS) } -> token(Ts), tokens(Cs, StpS, [])
; tokens(Cs, StpS, [C|Ts])).

token([]) --> [].
token([T|Ts]) --> { reverse([T|Ts], Token) }, [Token].
