%%%%GRAMMAR%%%%%

:-[world].

%phrase(-Predicate, -Object, +InputList, -EmptyList)
phrase(Pred, Obj) --> vp(SubCat, Pred), np(SubCat, Obj).

%vp(-Subcategory, -Predicate, +InputList, -WithoutVerb)
vp(location, go) --> [go];[go,to];[goto].
vp(intrans, Pred) --> intrans_v(Pred).
vp(trans_p, Pred) --> trans_p_v(Pred).
vp(trans_t, Pred) --> trans_t_v(Pred).

%intrans_v(-Predicate, +InputList, -WithoutVerb)
intrans_v(write_code) --> [write,code];[write,some,code].
intrans_v(help) --> [help];[h].
intrans_v(quit) --> [quit];[exit];[give,up].

%trans_p_v(-Pred, +InputList, -WithoutVerb)
trans_p_v(seduce) --> [seduce].
trans_p_v(blackmail) --> [blackmail].
trans_p_v(punch) --> [punch].
trans_p_v(cry) --> [cry,on];[cry].
trans_p_v(bribe) --> [bribe].

%trans_t_v(-Pred, +InputList, -WithoutVerb)
trans_t_v(drink) --> [drink].


%np(-Subcategory, -Object, +InputList, -WithoutNoun)
np(SubCat, Obj) --> d, n_bar(SubCat, Obj).
np(SubCat, Obj) --> n_bar(SubCat,Obj).

%n_bar(-Subcategory, -Object, +InputList, -WithoutNoun)
n_bar(trans_p, Obj) --> n(Obj), {person(Obj)}.
n_bar(trans_t, Obj) --> n(Obj), {thing(Obj)}.
n_bar(location, Place) --> n(Place), {place(Place)}.

%n(-Object, +InputList, -WithoutNoun) 
n(bar) --> [bar].
n(home) --> [home].
n(lab) --> [lab].
%n(jail) --> [jail].
n(policeman) --> [policeman];[popo];[po-po].
n('TA') --> ['TA'].
n('Kim') --> ['Kim'].
n(jailer) --> [jailer].
n('random stranger') --> [random,stranger].
n(drink) --> [beer];[cocktail].
n(shoulder) --> [shoulder].
n(scheduler) --> [scheduler,game];[scheduler].
n('text adventure game') --> [text,adventure,game];[text,game];[game].

%d(+InputList, -WithoutDeterminer)
d --> [the];[a].

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