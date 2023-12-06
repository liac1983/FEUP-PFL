% 1. How the Cut works
s(1).
s(2):- !.
s(3).

% 2. The effect of a Cut
data(one).
data(two).
data(three).
cut_test_a(X):- data(X).
cut_test_a(‘five’).
cut_test_b(X):- data(X), !.
cut_test_b(‘five’).
cut_test_c(X, Y):- data(X), !, data(Y).
cut_test_c(‘five’, ‘five’).

% 3. Red and Green Cuts
immature(X):- adult(X), !, fail. %This cut (!) appears after adult(X). Here, it is a "green cut." It cuts off any further choices in the adult(X) goal, but it doesn't impact the overall success or failure of the predicate. In this context, it ensures that if adult(X) succeeds (i.e., X is an adult), it immediately fails and prevents any backtracking.
immature(_X). % This cut (!) appears after person(X). It is a "red cut" because it prunes the search tree in a way that significantly affects the success or failure of the predicate. If person(X) succeeds, the cut ensures that no further choice points are explored. If person(X) fails, the cut will not be reached, and the predicate continues.
adult(X):- person(X), !, age(X, N), N >=18. % Similar to the previous case, this cut is a "red cut." It prunes the search tree if turtle(X) succeeds, preventing any further choices.
adult(X):- turtle(X), !, age(X, N), N >=50. % Again, this cut is a "red cut." If spider(X) succeeds, it prunes the search tree for any other alternatives.
adult(X):- spider(X), !, age(X, N), N>=1. % This cut is also a "red cut." If bat(X) succeeds, it ensures that no further choices are explored for this goal.
adult(X):- bat(X), !, age(X, N), N >=5.

% 4. Maximum Value
max(A, B, C, Max) :-
    (   A >= B, A >= C -> Max = A
    ;   B >= A, B >= C -> Max = B
    ;   C >= A, C >= B -> Max = C
    ).

% 5. Data Input and Output
% a)
% Base case: When N is 0, stop recursion.
print_n(0, _).

% Recursive case: Print the symbol S and decrement N.
print_n(N, S) :-
    N > 0,
    write(S),
    N1 is N - 1,
    print_n(N1, S).

% b)

print_text(Text, Symbol, Padding) :-
    atom_chars(Text, TextChars),
    atom_chars(Symbol, SymbolChars),
    repeat(SymbolChars, Padding, PaddingChars),
    append(PaddingChars, TextChars, PaddedTextChars),
    append(PaddedTextChars, PaddingChars, OutputChars),
    atom_chars(Output, OutputChars),
    write(Output).

% Helper predicate to repeat a list N times
repeat(_, 0, []).
repeat(List, N, Result) :-
    N > 0,
    append(List, Rest, Result),
    N1 is N - 1,
    repeat(List, N1, Rest).
