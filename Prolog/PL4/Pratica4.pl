% 1

s(1). 
s(2):- !. 
s(3). 

% 1.a
/* s(X).
X = 1 ? ;
X = 2 ? ; */

% 1.b
/* s(X), s(Y). 

X = 1,
Y = 1 ? yes*/

% 1.c
/*s(X), !, s(Y). 

X = 1,
Y = 1 ? yes*/

% 2
data(one). 
data(two).
data(three).
cut_test_a(X):- data(X). 
cut_test_a(‘five’). 
cut_test_b(X):- data(X), !. 
cut_test_b(‘five’). 
cut_test_c(X, Y):- data(X), !, data(Y). 
cut_test_c(‘five’, ‘five’).

% 2.a
/* cut_test_a(X), write(X), nl, fail. 
one
two
three*/

% 2.b
/*
cut_test_b(X), write(X), nl, fail. 
one
*/

% 2.c
/*
cut_test_c(X, Y), write(X-Y), nl, fail. 
one-one
one-two
one-three
*/

% 3
%adult(john).
% Red Cut
immature(X):- adult(X), !, fail. 
immature(_X). 
% Green Cut 
adult(X):- person(X), !, age(X, N), N >=18. 
adult(X):- turtle(X), !, age(X, N), N >=50. 
adult(X):- spider(X), !, age(X, N), N>=1. 
adult(X):- bat(X), !, age(X, N), N >=5. */

% 4
max(A, B, C, Max):-
    A >= B, A >= C, ! , Max = A.

max (A, B, C, Max):-
    B >= C, !, Max = B.
max(_,_,C, C).

% 5.a
print_n(N,S):-
    N > 0,
    write(S),
    N1 is N - 1,
    print_n(N1, S).
print_n(0,_):- !.

% 5.b

% print_text(+Text, +Symbol, +Padding)
print_text(Text, Symbol, Padding) :-
    print_symbol(Symbol),
    print_padding(Padding),
    write('"'), write_list(Text), write('"'),
    print_padding(Padding),
    print_symbol(Symbol),
    nl.

% Helper to print the symbol
print_symbol(Symbol) :-
    write(Symbol).

% Helper to print padding spaces
print_padding(0) :- !.
print_padding(N) :-
    N > 0,
    write(' '),
    N1 is N - 1,
    print_padding(N1).

write_list([]).
write_list([H|T]):-
    char_code(Leter, H),
    write(Leter),
    write_list(T).


% 5.c Errado !!!!!
% print_banner(+Text, +Symbol, +Padding)
print_banner(Text, Symbol, Padding) :-
    convert_to_string(Text, StringText), % Converte o texto de ASCII para string
    string_length(StringText, TextLength),
    TotalWidth is (Padding * 2) + TextLength + (2 * string_length(Symbol)),
    print_horizontal_line(TotalWidth, Symbol), % Linha superior
    print_empty_line(TotalWidth, Symbol),      % Linha vazia antes do texto
    print_text_line(StringText, Symbol, Padding), % Linha com o texto
    print_empty_line(TotalWidth, Symbol),      % Linha vazia depois do texto
    print_horizontal_line(TotalWidth, Symbol). % Linha inferior

% Helper to print a horizontal line
print_horizontal_line(Width, Symbol) :-
    Times is Width // string_length(Symbol),
    print_symbol_repeated(Symbol, Times),
    nl.

% Helper to print a single empty line
print_empty_line(Width, Symbol) :-
    write(Symbol),
    Spaces is Width - (2 * string_length(Symbol)),
    print_padding(Spaces),
    write(Symbol),
    nl.

% Helper to print the text line
print_text_line(Text, Symbol, Padding) :-
    write(Symbol),
    print_padding(Padding),
    write('"'), write(Text), write('"'),
    print_padding(Padding),
    write(Symbol),
    nl.

% Helper to print a repeated symbol
print_symbol_repeated(_, 0) :- !.
print_symbol_repeated(Symbol, N) :-
    write(Symbol),
    N1 is N - 1,
    print_symbol_repeated(Symbol, N1).

% Helper to print padding spaces
print_padding(0) :- !.
print_padding(N) :-
    N > 0,
    write(' '),
    N1 is N - 1,
    print_padding(N1).

% Helper to convert ASCII list to string
convert_to_string(Text, StringText) :-
    (   is_list(Text) ->     % Verifica se é uma lista de códigos ASCII
        string_codes(StringText, Text) % Converte de ASCII para string
    ;   StringText = Text).  % Caso já seja uma string, mantém como está


% 5.d
% read_number(-X)
read_number(X) :-
    read_digits(Digits),      % Lê os dígitos como uma lista
    number_from_digits(Digits, X). % Converte a lista de dígitos em um número inteiro

% Helper to read digits until a line feed (ASCII 10) is found
read_digits(Digits) :-
    peek_code(Code),          % Olha o próximo caractere
    (   Code =:= 10 ->        % Se for Line Feed (10), termina
        get_code(_),          % Consome o Line Feed
        Digits = []           % Lista de dígitos vazia
    ;   Code >= 48, Code =< 57 -> % Verifica se é um código ASCII de dígito (48 = '0', 57 = '9')
        get_code(Code),       % Consome o caractere
        Digit is Code - 48,   % Converte o código ASCII para o número correspondente
        read_digits(Rest),    % Lê os dígitos restantes
        Digits = [Digit | Rest]
    ;   get_code(_),          % Ignora caracteres não numéricos
        read_digits(Digits)
    ).

% Helper to convert a list of digits into an integer
number_from_digits(Digits, Number) :-
    number_from_digits(Digits, 0, Number).

% Recursive helper to calculate the number from digits
number_from_digits([], Acc, Acc).
number_from_digits([D|Ds], Acc, Number) :-
    NewAcc is Acc * 10 + D,    % Multiplica o acumulador por 10 e adiciona o dígito atual
    number_from_digits(Ds, NewAcc, Number).


% 5.e

% 5.f

% 5.g

% 5.h


% 5.i
% oh_christmas_tree(+N): Imprime uma árvore de Natal de tamanho N.
oh_christmas_tree(N) :-
    print_tree(N, 1),  % Imprime as linhas da árvore.
    print_trunk(N).    % Imprime o tronco.

% print_tree(+TotalLines, +CurrentLine): Imprime as linhas da árvore.
print_tree(TotalLines, CurrentLine) :-
    CurrentLine =< TotalLines,               % Continua se a linha atual não exceder o total.
    Stars is 2 * CurrentLine - 1,            % Calcula o número de estrelas na linha.
    Spaces is TotalLines - CurrentLine,      % Calcula o número de espaços antes das estrelas.
    print_padding(Spaces),                   % Imprime os espaços à esquerda.
    print_n(Stars, '*'),                     % Imprime as estrelas.
    nl,                                      % Pula para a próxima linha.
    NextLine is CurrentLine + 1,             % Avança para a próxima linha.
    print_tree(TotalLines, NextLine).        % Recursivamente imprime as próximas linhas.
print_tree(_, _).  % Caso base: termina quando todas as linhas forem impressas.

% print_trunk(+N): Imprime o tronco da árvore.
print_trunk(N) :-
    Spaces is N - 1,         % O tronco está centralizado, com N-1 espaços antes.
    print_padding(Spaces),   % Imprime os espaços antes do tronco.
    write('*'), nl.          % Imprime o tronco e pula para a próxima linha.

% print_padding(+N): Imprime N espaços.
print_padding(0) :- !.
print_padding(N) :-
    N > 0,
    write(' '),
    N1 is N - 1,
    print_padding(N1).

% print_n(+N, +Symbol): Imprime o símbolo N vezes.
print_n(0, _) :- !.
print_n(N, Symbol) :-
    N > 0,
    write(Symbol),
    N1 is N - 1,
    print_n(N1, Symbol).


% 6.a
% Base case: an empty list
print_full_list([]) :-
    write(''), !. % Write nothing for an empty list

% Case with one element: no trailing comma or space
print_full_list([X]) :-
    write(X), !.

% Recursive case: write the current element, a comma, and a space, then recurse
print_full_list([X|Xs]) :-
    write(X),
    write(', '),
    print_full_list(Xs).

% 6.b
% Caso 1: Lista com até 11 elementos, imprime toda a lista
print_list(L) :-
    length(L, N),
    N =< 11, !,
    write('['),
    print_full_list(L),
    write(']').

% Caso 2: Lista com 12 ou mais elementos, imprime grupos com "..."
print_list(L) :-
    length(L, N),
    N >= 12, !,
    % Pegar os primeiros 3 elementos
    length(First, 3),
    append(First, Rest, L),
    % Pegar os 3 elementos do meio
    length(Rest, RestLen),
    MiddleStart is RestLen // 2 - 1,
    length(Middle, 3),
    append(_, MiddleAndRest, Rest),
    append(Middle, End, MiddleAndRest),
    % Pegar os últimos 3 elementos
    length(End, 3),
    write('['),
    print_full_list(First),
    write(', ..., '),
    print_full_list(Middle),
    write(', ..., '),
    print_full_list(End),
    write(']').

% print_full_list implementado anteriormente:
print_full_list([]) :- !.
print_full_list([X]) :- write(X), !.
print_full_list([X|Xs]) :-
    write(X),
    write(', '),
    print_full_list(Xs).


% 6.c
% print_matrix/1: Imprime uma matriz (lista de listas).
print_matrix([]) :- 
    write('yes'), nl. % Quando a matriz estiver vazia, termina com "yes".
print_matrix([Row|Rest]) :-
    write('['),  % Inicia a linha com '['.
    print_row(Row), % Imprime os elementos da linha.
    write(']'), nl, % Fecha a linha com ']' e pula para a próxima linha.
    print_matrix(Rest). % Recursivamente imprime o resto da matriz.

% print_row/1: Imprime os elementos de uma linha separados por vírgulas.
print_row([]).
print_row([Element]) :-
    write(Element). % O último elemento da linha (sem vírgula).
print_row([Element|Rest]) :-
    write(Element), write(', '), % Escreve o elemento seguido de uma vírgula.
    print_row(Rest). % Recursivamente imprime os outros elementos.


% 6.d
% print_numbered_matrix/1: Imprime uma matriz numerada.
print_numbered_matrix(Matrix) :-
    length(Matrix, Length),             % Calcula o número de linhas na matriz.
    number_padding(Length, Padding),    % Determina o tamanho do padding para os números.
    print_numbered_matrix(Matrix, 1, Padding), % Chama o predicado auxiliar com o contador inicial.
    write('yes'), nl.                   % Finaliza com "yes".

% print_numbered_matrix/3: Versão auxiliar com contador de linha e padding.
print_numbered_matrix([], _, _). % Caso base: fim da matriz.
print_numbered_matrix([Row|Rest], LineNum, Padding) :-
    format_number(LineNum, Padding, FormattedNum), % Formata o número da linha com padding.
    write(FormattedNum), write(' '),               % Imprime o número seguido de espaço.
    write('['),                                    % Abre a linha com '['.
    print_row(Row),                                % Imprime os elementos da linha.
    write(']'), nl,                                % Fecha a linha com ']' e pula para a próxima linha.
    NextLine is LineNum + 1,                       % Incrementa o contador de linhas.
    print_numbered_matrix(Rest, NextLine, Padding). % Recursivamente imprime o resto da matriz.

% print_row/1: Imprime os elementos de uma linha separados por vírgulas.
print_row([]).
print_row([Element]) :-
    write(Element). % O último elemento da linha (sem vírgula).
print_row([Element|Rest]) :-
    write(Element), write(', '), % Escreve o elemento seguido de uma vírgula.
    print_row(Rest). % Recursivamente imprime os outros elementos.

% number_padding/2: Calcula o padding necessário para alinhar os números.
number_padding(Number, Padding) :-
    number_chars(Number, Chars), % Converte o número em lista de caracteres.
    length(Chars, Padding).      % O tamanho da lista de caracteres é o padding.

% format_number/3: Formata um número com padding.
format_number(Number, Padding, FormattedNum) :-
    number_chars(Number, Chars),           % Converte o número em lista de caracteres.
    length(Chars, NumLen),                 % Determina o comprimento do número.
    Spaces is Padding - NumLen,            % Calcula o número de espaços para o padding.
    pad_left(Spaces, PaddedSpaces),        % Gera os espaços de padding.
    atom_chars(NumberAtom, Chars),         % Converte a lista de caracteres para um átomo.
    atom_concat(PaddedSpaces, NumberAtom, FormattedNum). % Junta o padding com o número.

% pad_left/2: Gera uma string de espaços de tamanho N.
pad_left(0, '') :- !.
pad_left(N, PaddedSpaces) :-
    N > 0,
    length(SpaceList, N),        % Cria uma lista de tamanho igual a N.
    maplist(=(' '), SpaceList),  % Preenche a lista com espaços.
    atom_chars(PaddedSpaces, SpaceList). % Converte a lista de espaços para um átomo.

% maplist/2: Aplica Predicado a todos os elementos da Lista.
maplist(_, []) :- !. % Caso base: lista vazia.
maplist(Predicate, [Head|Tail]) :-
    call(Predicate, Head), % Chama o predicado para o elemento atual.
    maplist(Predicate, Tail). % Recursivamente aplica o predicado ao restante da lista.


% 6.e

% print_list/4: Imprime uma lista usando S como símbolo inicial, Sep como separador, e E como símbolo final.
print_list(List, S, Sep, E) :-
    write(S),                  % Imprime o símbolo inicial.
    print_list_elements(List, Sep), % Imprime os elementos da lista com o separador.
    write(E), nl,              % Imprime o símbolo final e uma nova linha.
    write('yes'), nl.          % Finaliza com "yes".

% print_list_elements/2: Imprime os elementos da lista com o separador fornecido.
print_list_elements([]).
print_list_elements([Element]) :-
    write(Element).            % O último elemento é impresso sem o separador.
print_list_elements([Element|Rest], Sep) :-
    write(Element),            % Imprime o elemento atual.
    write(Sep),                % Imprime o separador.
    print_list_elements(Rest, Sep). % Recursivamente imprime os outros elementos.


