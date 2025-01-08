% 1 (youtube: prolog by example)
:- dynamic male/1, female/1, parent/2.
:- dynamic winning_move/2.
:- dynamic invert_predicate_clause_order/0.

% Male definitions
male(frank).
male(jay).
male(javier).
male(bo).
male(phil).
male(mitchell).
male(joe).
male(manny).
male(dylan).
male(alex).
male(luke).
male(cameron).
male(pameron).
male(george).
male(rexford).
male(calhoun).

% Female definitions
female(grace).
female(dede).
female(gloria).
female(barb).
female(claire).
female(haley).
female(lily).
female(poppy).

% Parent definitions
parent(grace, phil).
parent(frank, phil).

parent(dede, claire).
parent(jay, claire).

parent(dede, mitchell).
parent(jay, mitchell).

parent(jay, joe).
parent(gloria, joe).

parent(gloria, manny).
parent(javier, manny).

parent(phil, haley).
parent(claire, haley).

parent(phil, alex).
parent(claire, alex).

parent(phil, luke).
parent(claire, luke).

parent(mitchell, lily).
parent(cameron, lily).

parent(mitchell, rexford).
parent(cameron, rexford).

parent(dylan, george).
parent(haley, george).

parent(dylan, poppy).
parent(haley, poppy).

parent(pameron, calhoun).
parent(bo, calhoun).

add_person(male, name):-
    \+ male(Name),
    assertz(male(Name)).

add_person(female, Name):-
    \+ female(Name),
    assertz(female(Name)).

% 1.c
remove_person:-
    read(Name),
    (male(Name)->retract(male(Name));
    female(Name)->retract(female(Name))),

    retractall(parent(Name, _)),
    retractall(parent(_,Name)).

% 1.d
update_birthdates:-
    update_male_birthdates,
    update_female_birthdates,
    write('All birthdates updated!'), nl.

update_male_birthdates:-
    male(Name),
    write('What is the year of birth of '), write(Name), write('? '), nl,
    read(Year),
    retract(male(Name)),
    assertz(male(Name, Year)),
    fail.
update_male_birthdates.

update_female_birthdates:-
    female(Name),
    write('What is the year of birth of '), write(Name), write('? '), nl,
    read(Year),
    retract(female(Name)),
    assertz(female(Name, Year)),
    fail.
update_female_birthdates.

% 1.g
print_descendents(Person):-
    write('Children:'), nl,
    parent(Person, Child),
    write(child), nl,
    fail;
    true,

    write('grandchildren:'), nl,
    parent(Person, Child),
    parent(Child, Grandchild),
    write(Grandchild), nl,
    fail;
    true.

% 2.a
double(X,Y) :- Y is X * 2.

map(_, [], []).
map(Pred, [H1|T1], [H2|T2]):-
    call(Pred, H1, H2),
    map(Pred, T1, T2).

% 2.b
fold(_,FinalValue, [], FinalValue).
fold(Pred, StartValue, [H|T], FinalValue):-
    call(Pred, StartValue, H, Res),
    fold(Pred, Res, T, FinalValue).


% 2.c
separate([], _, [], []).
separate([H|T], Pred, [H|Yes], No):-
    call(Pred, H),
    separate(T, Pred, Yes, No).

separate([H|T], Pred, yes, [H|No]):-
    \+ call(Pred, H),
    separate(T, Pred, Yes, No).

% 2.d Divide a lista em front e end
take_while(_, [], [], []).
take_while(Pred, [H|T], [H|Front], Back):-
    call(Pred, H),
    take_while(Pred, T, Front, Back).

take_while(Pred, [H|T], [], [H|T]):-
    \+ call(Pred, H).

% 4.a
tree_size(leaf(_), 1).
tree_size(tree(_, Left, Right), Size):-
    tree_size(Left, LeftSize),
    tree_size(Right, RightSize),
    Size is 1 + LeftSize + RightSize.

% 4.b constroi uma nova arvore com a mesma estrutura
tree_map(Pred, leaf(x), leaf(Y)):-
    call(Pred, X, Y).

tree_map(Pred, tree(Value, Left, Right), tree(NewValue, NewLeft, NewRight)):-
    call(Pred, Value, NewValue),
    tree_map(Pred, Left, NewLeft),
    tree_map(Pred, Right, NewRight).


