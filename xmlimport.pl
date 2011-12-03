
% find_summary(+FileLoc, -Summary)
% FileLoc should be a google calendar xml file
% Summary will unify with a calendar entry summary,
% which will be of the form: Mon 12 Dec 2011 12:00 to 15:00
% or Tue 13 Dec 2011 08:00 to Tue 13 Dec 2011 16:00
find_summary(FileLoc, Summary) :-
	load_xml_file(FileLoc, DOM),
	DOM=[element(_, _, RootContents)],
	member(element('entry', _, EntryContents), RootContents),
	member(element('summary', _, SummaryContents), EntryContents),
	SummaryContents = [X|Xs],
	concat('When: ', RemoveWhen, X),
	upto_amper(Summary, RemoveWhen).
	
% Upto contains the string up to the first ampersand
% encountered in the List string
% This should be good enough for our purposes.
upto_amper(Upto, List) :-
	atom_codes('&', AmperCodeList),
	atom_codes(List, ListCodes),
	AmperCodeList=[AmperCode|_],
	nth0(AmperIndex, ListCodes, AmperCode),
	sub_string(List, 0, AmperIndex, _, Upto).

% get_all_summaries(+FileLoc)
% Prints all of the summaries found in the google calendar
% xml file provided.
% Later, instead of printing the summaries we will do 
% something more useful with them (ie. assert them as rules)
get_all_summaries(FileLoc) :- 
	forall(find_summary(FileLoc, Summary), (write(Summary), writef("\n"))).