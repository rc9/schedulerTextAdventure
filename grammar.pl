:-[tokenizer].

s --> np(Number), vp(Number).

np(singular) --> d, n.
np(plural) --> ns.

vp(singular) --> b, a, addp.
vp(singular) --> v, addp.
vp(plural) --> bs, a, addp.
vp(plural) --> vs, addp.

pp --> p, np(_).

addp --> np(_).
addp --> pp.


d --> [the]; [a].
n --> [hanna];[monday].
ns --> [mondays].
a --> [busy].
a --> [free].
b --> [is].
bs --> [are].
v --> [works].
vs --> [work].
dayp --> [on]. 
timep --> [from]; [to].
