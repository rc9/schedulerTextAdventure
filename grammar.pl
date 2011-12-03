s --> q, !.
s --> np(Number), vp(Number).

q --> aux, np(_), addp.
q --> auxs, np(_), addp.
q --> whp, modal, np(_), vp(plural).
q --> aux, !.
q --> auxs, !.
q --> whp, !.

np(singular) --> n.
%np(plural) --> ns.
np(plural) --> conjp.
np(_) --> !.

vp(singular) --> aux, addp.
vp(singular) --> v, !, pp.
vp(plural) --> auxs, addp.
vp(plural) --> vs, !, pp.

pp --> dayp, dayn.
pp --> timep, timen, timep, timen.

%addp --> a, np(_).
addp --> a, pp.

conjp --> np(_), !, conj_bar.
conj_bar --> conj, np(_).

%Determiner
%d --> [the]; [a]; [].
%Noun
n --> [hanna];[riley];[rob].
dayn --> [monday];[mondays].
timen --> [10:00]; [13:00];[14:23].
%Adjective
a --> [busy].
a --> [free].
%Auxiliary
aux --> !, [is];[does].
auxs --> !, [are];[do].
%Verb
v --> [works].
vs --> [work];[meet].
%Preposition
dayp --> [on]. 
timep --> [from]; [to].
%Conjunction
conj --> [and].
%WH-Phrase
whp --> [when];[what, time].
%Modal
modal --> [can].