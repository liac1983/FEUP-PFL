% 4
% Qual é o valor mais alto entre 3 numeros ?
max(A,B,C, Max):-
    A >= B, A >= C, ! , Max = A.

max(A,B,C, Max) :-
    B >= C, !, Max = B.

max(_,_, C, C).

% 5
% Imprime o simbolo S no terminal N vezes
print_n(N,S):-
    N > 0,
    write(S),
    N1 is N - 1,
    print_n(N1, S).

print_n(0,_) :- !.

% 5.b
% prints the text received in the first argument (using double quotes) with the padding received in the third argument

print_text(Text, Symbol, Padding):-
    print_symbol(Symbol),
    print_padding(Padding),
    write('"'), write_list(Text), write('"'),
    print_padding(Padding),
    print_symbol(Symbol),
    nl.

print_symbol(Symbol):-
    write(Symbol).

print_padding(0).
print_padding(N):-
    N > 0,
    write(' '),
    N1 is N - 1,
    print_padding(N1).

write_list([]).
write_list([H|T]):-
    char_code(Letter, H),
    write(Leter, H),
    write_list(T).

% 5.c
% print_banner(+Text, +Symbol, +Padding)
print_banner(Text, Symbol, Padding) :-
    string_length(Text, TextLength),
    TotalWidth is TextLength + 2 * Padding + 4,
    print_line(Symbol, TotalWidth),
    nl,
    print_empty_line(Symbol, TotalWidth),
    nl,
    print_text_line(Text, Symbol, Padding),
    nl,
    print_empty_line(Symbol, TotalWidth),
    nl,
    print_line(Symbol, TotalWidth),
    nl.

% print_line(+Symbol, +Length)
% Imprime uma linha com o símbolo dado e o comprimento especificado.
print_line(_, 0).
print_line(Symbol, Length) :-
    Length > 0,
    write(Symbol),
    NextLength is Length - 1,
    print_line(Symbol, NextLength).

% print_empty_line(+Symbol, +Width)
% Imprime uma linha vazia com o símbolo nas extremidades.
print_empty_line(Symbol, Width) :-
    write(Symbol),
    SpaceWidth is Width - 2,
    print_spaces(SpaceWidth),
    write(Symbol).

% print_spaces(+Count)
% Imprime um número especificado de espaços.
print_spaces(0).
print_spaces(Count) :-
    Count > 0,
    write(' '),
    NextCount is Count - 1,
    print_spaces(NextCount).

% print_text_line(+Text, +Symbol, +Padding)
% Imprime o texto centralizado com o símbolo nas extremidades e o padding especificado.
print_text_line(Text, Symbol, Padding) :-
    write(Symbol),
    print_spaces(Padding),
    write(Text),
    print_spaces(Padding),
    write(Symbol).

% 6.a
print_full_list([]):-
    write(''), !.

print_full_list([X]):-
    write(X), !.

print_full_list([X|Xs]):-
    write(X),
    write(', '),
    print_full_list(Xs).

% 6.c
print_matrix([]):-
    write('yes'), nl.
print_matrix([Row|Rest]):-
    write('['),
    print_row(Row),
    write(']'),
    print_matrix(Rest).

print_row([]).
print_row([Element]):-
    write(Element).

print_row([Element|Rest]):-
    write(Element), write(', '),
    print_row(Rest).

