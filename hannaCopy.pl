:-[tokenizer].

s --> np(Number), vp(Number).

np(singular) --> d, n.
np(plural) --> ns.

o(day) --> ndays.
o(day) --> nday.
o(ntime) --> ntime.

vp(singular) --> b, a, addp.
vp(singular) --> v, addp.
vp(plural) --> bs, a, addp.
vp(plural) --> vs, addp.

addp --> np(_).
addp --> pp.

pp --> dayp, o(day).
pp --> timep, o(ntime), timep, o(ntime).


d --> [the]; [a]; [].
n --> [monday];[hanna].
ns --> [mondays].
nday --> [monday].
ndays --> [mondays].
ntime --> [3:00]; [18:00].
a --> [busy]; [free].
b --> [is].
bs --> [are].
v --> [works].
vs --> [work].
dayp --> [on]. 
timep --> [from]; [to]; ['for'].

/*
works = can mean two diff. things
1) If a subject is 'a person' say, Hanna works from..to.. means, the time is unavailable for scheduling.
2) If a subject is 'a day' say, Mondays work for Hanna, the time is available for scheduling.

for - same as above
1) can be used for certain amount of hours ex. for x hours
2) can be used to indicate a person, Mondays work for Hanna.
*/