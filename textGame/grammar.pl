%%%%GRAMMAR%%%%%
:-[world].

%phrase(-Predicate, -Object, +InputList, -EmptyList)
phrase([Pred, Patient, Obj]) --> vp(SubCat, Pred), np(SubCat, Patient), pp(Obj).
phrase([Pred, Patient]) --> vp(SubCat, Pred), np(SubCat, Patient).
phrase([Pred]) --> vp(intrans, Pred).

%% Verbs %%
%A verb phrase that determines which type of verb to use.
%vp(-Subcategory, -Predicate, +InputList, -WithoutVerb)
vp(location, go) --> [go];[go,to];[goto].
vp(intrans, Pred) --> intrans_v(Pred).
vp(trans_p, Pred) --> trans_p_v(Pred).
vp(trans_t, Pred) --> trans_t_v(Pred).

%Intransitive verbs take no arguments after the verb.
%intrans_v(-Predicate, +InputList, -WithoutVerb)
intrans_v(write_code) --> [write,code];[write,some,code].
intrans_v(help) --> [help];[h].
intrans_v(quit) --> [quit];[exit];[give,up].
intrans_v(where) --> [where].

%Transitive verbs are used with a person
%trans_p_v(-Pred, +InputList, -WithoutVerb)
trans_p_v(seduce) --> [seduce].
trans_p_v(blackmail) --> [blackmail].
trans_p_v(punch) --> [punch].
trans_p_v(cry) --> [cry,to];[cry,at];[cry].
trans_p_v(bribe) --> [bribe].

%Transitive verbs for objects
%trans_t_v(-Pred, +InputList, -WithoutVerb)
trans_t_v(drink) --> [drink].
trans_t_v(drop) --> [drop];[leave];[abandon].
trans_t_v(pickUp) --> [pick,up];[take];[pick];[grab].

%% Nouns %%
%Noun phrase choses to use a determiner or not
%np(-Subcategory, -Object, +InputList, -WithoutNoun)
np(SubCat, Obj) --> d, n_bar(SubCat, Obj).
np(SubCat, Obj) --> n_bar(SubCat,Obj).

%N' matches whether the verb needs an object or a person
%n_bar(-Subcategory, -Object, +InputList, -WithoutNoun)
n_bar(trans_p, Obj) --> n(Obj), {person(Obj)}.
n_bar(trans_t, Obj) --> n(Obj). % {thing(Obj)}.
n_bar(location, Place) --> n(Place), {place(Place)}.

%Nouns of places
%n(-Object, +InputList, -WithoutNoun) 
n(bar) --> [bar].
n(house) --> [house];[home].
n(lab) --> [lab].
n(jail) --> [jail].

%Nouns of persons
n(policeman) --> [policeman];[popo];[po-po].
n('TA') --> [ta];[kenny];[ben].
n('Kim') --> [kim].
n(jailer) --> [jailer].
n(bartender) --> [bartender].
n(mom) --> [mom];[mother];[ma];[mommy].
n(brother) --> [brother];[bro].
n('random stranger') --> [random,stranger].

%Nouns of objects
n(drink) --> [beer];[soda];[pop];[cocktail].
n(shoulder) --> [shoulder].
n(scheduler) --> [scheduler,game];[scheduler].
n('text adventure game') --> [text,adventure,game];[text,game];[game].
n(iphone) --> [iphone];[phone].
n(money) --> [money];[cash];[dough];[moolah].
n(fakeId) --> [fake,id];[id].
n(flowers) --> [flowers].


%% Prepositions %%
%pp(-Object, +InputList, -WithoutPrepositionPhrase)
pp(Obj) --> p, np(Obj).

%(+InputList, WithoutPreposition).
p --> [with];[in];[at].

%Determiner that may appear with a noun
%d(+InputList, -WithoutDeterminer)
d --> [the];[a];[some].

 /*
%Places
%place(+Place)
place(home).
place(bar).
place(jail).
place(lab).

%People
%person(+Person)
person('TA').
person('Kim').
person(policeman).
person('random stranger').
person(jailer).

%Things
%thing(+Thing)
thing(scheduler).
thing('text adventure game').
thing(drink).
thing(shoulder).

*/