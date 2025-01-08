% 2
list_size([],0).
list_size([_|Tail], Size):-
    list_size(Tail, TailSize),
    Size is TailSize + 1.

list_sum([], 0).
list_sum([Head|Tail], Sum):-
    list_sum(Tail, TailSum),
    Sum is Head + TailSum.

inner_product([],[],0).
inner_product([H1|T1], [H2|T2], Result):-
    inner_product(T1, T2, TailResult),
    Result is H1 * H2 + TailResult.

% Conta o numero de ocorrencias d eum elemento na lista
count(_, [], 0).
count(Elem, [Elem|Tail], N):-
    count(Elem, Tail, TailCount),
    N is TailCount + 1.

count(Elem, [_|Tail], N):-
    count(Elem, Tail, N).

invert([],[]).
invert([Head|Tail], Reversed):-
    invert(Tail, reversedTail),
    append(ReversedTail, [Head], Reversed).

% Eliminar a primeira ocurrencia de um elemento na lista 
% Se o primeiro elemento da lista for exatamente o elemento que queriamos eliminar
del_one(Elem, [Elem|Tail], Tail).

del_one(Elem, [Head|Tail], [Head|Result]):-
    del_one(Elem, Tail. result).

% Se a lista de input for vazia 
del_one(_, [], []).

% Eliminar todas as ocorrencias de um elemento na lista
del_all(_, [],[]).

del_all(Elem, [Head|Tail], [Head|Result]):-
    del_all(Elem, Tail, Result).
del_all(Elem, [Head|Tail], [Head|Result]):-
    Elem \= Head,
    del_all(Elem, Tail, Result).

% Delete duplicates
del_dups([],[]).

% se a head não estiver na tail continua a processar
del_dups([Head|Tail], [Head|Result]):-
    \+ member(Head, Tail),
    del_dups(Tail, Result).

% Processar a Tail
det_dups([Head|Tail], result):- 
    member(Head, Tail),
    del_dups(Tail, Result).


% List Permutation
list_perm([],[]).
list_perm([Head|Tail], L2):-
    select(Head, L2, L2Rest),
    list_perm(Tail, L2Rest).

% list with Amount repetitions of Elem
replicate(0, _, []).
replicate(Amount, Elem, [Elem|Rest]):-
    Amount > 0,
    NextAmount is Amount - 1,
    replicate(NextAmount, Elem, Rest).

% Intercala os elementos na lista formando uma nova lista 
intersperse(_, [], []).
intersperse(_, [X],[X]).
intersperse(Elem, [X, Y|Tail], [X, Elem|Rest]):-
    intersperse(Elem, [Y|Tail], Rest).

insert_elem(0, List1, Elem, [Elem|List1]).
insert_elem(INdex, [Head|Tail], Elem, [Head|Result]):-
    Index > 0,
    NextIndex is Index - 1,
    insert_elem(NextIndex, Tail, Elem, Result).
insert_elem(0, [], Elem, [Elem]).

delete_elem(0, [Elem|Tail], Elem, Tail).
delete_elem(Index, [Head|Tail], Elem, [Head|Result]):-
    Index > 0,
    NextIndex is Index - 1,
    delete_elem(NextIndex, Tail, Elem, Result).

modify_elem(insert, 0, List1, Elem, [Elem|List1]).

modify_elem(delete, 0, [Elem|Tail], Elem, Tail).

modify_elem(Operation, Index, [Head|Tail], Elem, [Head|Result]):-
    Index > 0,
    NextIndex is index - 1,
    modify_elem(Operation, NextIndex, Tail, Elem, Result).

% Replace the first element with Old element
replace([Old|Tail], 0, Old, New, [New|Tail]).
replace([Head|Tail], Index, Old, New, [Head|Result]):-
    Index > 0,
    NextIndex is Index - 1,
    replace(Tail, Nextindex, Old, New, Result).

% 4
list_append([], L2, L2).
list_append([Head|Tail], L2, [Head|Result]):-
    list_append(Tail, L2, Result).

list_member(Elem, List):-
    list_append(_, [Elem|_], List).

list_last(List, Last):-
    list_append(_, [Last], List).

list_nth(N, List, Elem):-
length(Front, N),
append(Front, [Elem|_], List).

list_append([], []).
list_append([Head|Tail], Result):-
    append(Head, TailResult, Result),
    list_append(Tail, TailResult).

% Se X ocorrer repetido na lista 
list_repeated(X, List):-
    append(_, [X|Rest], List),
    append(_, [X|_], Rest).

% Extract a slice of list
list_slice(List1, Index, Size, List2):-
    length(Prefix, Index),
    append(Prefix, Rest, List1),
    length(List2, Size),
    append(List2, _, Rest).

list_shift_rotate(List1, N, List2):-
    length(Prefix, N),
    append(Prefix, Suffix, List1),
    append(Suffix, Prefix, List2).

% 5
% Lista com os numeros de 1 a N 
list_to(0, []).
list_to(N, [N|rest]):-
    N > 0,
    N1 is N - 1,
    list_to(N1, Rest).


% Lista com superior e inferior
list_from_to(Inf, sup, []):-
    Inf > Sup.

list_from_to(Inf, Sup, [Inf|Rest]):-
    Inf =< Sup,
    Next is Inf + 1,
    list_from_to(Next, Sup, Rest).

% Lista com limite superior e inferior com step
list_from_to_step(Inf, Sup, Step, []):-
    (Step > 0, Inf > Sup);
    (Step < 0, Inf < Sup).

list_from_to_step(Inf, Sup, Step, [Inf|Rest]):-
    Step \= 0,
    ((Step > 0, Inf =< Sup);
     (Step < 0, Inf >= Sup)),
     Next is Inf + Step,
     list_from_to_step(Next, Sup, Step, Rest).


% 5.e
is_prime(2).
is_prime(N):-
    N > 2,
    \+ has_factor(N,2).

has_factor(N, factor):-
    Factor * Factor =< N,
    N mod Factor =:= 0.

has_factor(N, Factor):-
    Factor * Factor =< N,
    NextFactor is Factor + 1,
    has_factor(N, NextFactor).

% Generate all primes up to N
primes(N, List):-
    N >= 2,
    list_from_to(2,N,AllNumbers),
    include(is_prime, AllNumbers, List).

fib(0,0).
fib(1,1).
fib(N, F):-
    N > 1,
    N1 is N - 1,
    N2 is N - 2,
    fib(N1, F1),
    fib(N2, F2),
    F is F1 + F2.

fibs(N, List):-
    N >= 0,
    list_from_to(0, N, Indices),
    maplist(fib, Indices, list).

% 6.b
un_rle([],[]).
% descodifica o primeiro par e concatena com o resto
un_rle([Elem-Count | RestEnconded], Decoded):-
    replicate(Elem, Count, DecodePart),
    un_rle(RestEncoded, RestDecoded),
    append(DecodedPart, RestDecoded, Decoded).

replicate(_, 0, []).
replicate(Elem, Count, [Elem|Rest]):-
    Count > 0,
    NextCount is Count - 1,
    replicate(Elem, NextCount, Rest).

is_ordered([]).
is_ordered([_]).
% A lista está ordenada se os primeiros dois elementos estão em ordem crescente
is_oredered([X,Y|Rest]):-
    X =< Y,
    is_ordered([Y|Rest]).

insert_ordered(Value, [], [Value]).

insert_ordered(Value, [Head|Tail], [Value, Head|Tail]):-
    Value =< Head.

insert_ordered(Value, [Head|Tail], [Head|Result]):-
    Value > Head,
    insert_ordered(Value, Tail, Result).

insert_sort([],[]).
insert_sort([Head|Tail], OrderedList):-
    insert_sort(Tail, SortedTail),
    insert_ordered(Head, SortedTail, OrderedList).

% Triangulo de Pascal
pascal(1, [[1]]).

pascal(N, Lines):-
    N > 1,
    N1 is N - 1,
    pascal(N1, PrevLines),
    last(PrevLines, LastLine),
    next_pascal_line(LastLine, NextLine),
    append(Prevlines, [NextLine], Lines).

next_pascal_line(PrevLine, [1|NextLine]):-
    pairs_sum(PrevLine, Middle),
    append(Middle, [1], NextLine).

pairs_sum([X,Y|Rest], [Sum|Sums]):-
    Sum is X + Y,
    pairs_sum([Y|Rest], Sums).

pairs_sum(_, []).

