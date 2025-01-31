%author(AuthorID, Name, YearOfBirth, CountryOfBirth).
author(1,	'John Grisham',		1955,	'USA').
author(2,	'Wilbur Smith',		1933,	'Zambia').
author(3,	'Stephen King',		1947,	'USA').
author(4,	'Michael Crichton',	1942,	'USA').

%book(Title, AuthorID, YearOfRelease, Pages, Genres).
book('The Firm', 		1, 	1991, 	432,	['Legal thriller']).
book('The Client',		1,	1993,	422,	['Legal thriller']).
book('The Runaway Jury',	1,	1996,	414, 	['Legal thriller']).
book('The Exchange',		1,	2023,	338,	['Legal thriller']).

book('Carrie',			3,	1974,	199,	['Horror']).
book('The Shining',		3,	1977,	447,	['Gothic novel', 'Horror', 'Psychological horror']).
book('Under the Dome',		3,	2009,	1074,	['Science fiction', 'Political']).
book('Doctor Sleep',		3,	2013,	531,	['Horror', 'Gothic', 'Dark fantasy']).

book('Jurassic Park',		4,	1990,	399,	['Science fiction']).
book('Prey',			4,	2002, 	502, 	['Science fiction', 'Techno-thriller', 'Horror', 'Nanopunk']).
book('Next', 			4,	2006, 	528, 	['Science fiction', 'Techno-thriller', 'Satire']).

% 1
% associates a book title with the name of its author
book_author(Title, Author):-
    author(AuthID, Author, _YoB, _CoB),
    book(Title, AuthID, _YoP, _Pages, _Genres).

% 2
% unifies Title with the title of a book that has multiple genres
multi_genre_book(Title):-
    book(Title, _AuthID, _Year, _Pages, [_One, _Two|_Rest]).

% 3
% receives two book titles as arguments and returns on the third argument a list containing the genres that are common to both books
shared_genres(Title1, Title2, CommonGenres):-
    book(Title, _ID1, _Year1, _Pages1, Genres1),
    book(Title2, _ID2, _Year2, _Pages2, Genres2),
    common_elements(Genres1, Genres2, CommonGenres).

% Determine common elements between two lists
common_elements([], _L, []).
common_elements([H|T], L, [H|R]):-
    member(H, L), !, 
    common_elements(T, L, R).
common_elements([_|T], L, R):-
    common_elements(T, L, R).

% 4
% determines the Jaccard coefficient between the two books received as first two arguments, considering the genres of each book as the measure of similarity
similarity(Title1, Title2, Similarity) :-
    shared_genres(Title1, Title2, Intersection),
    book(Title1, _ID1, _Year1, _Pages1, Genres1),
    book(Title2, _ID2, _Year2, _Pages2, Genres2),
    union(Genres1, Genres2, Union),
    length(Intersection, LI),
    length(Union, LU),
    Similarity is LI / LU.

union(Set1, Set2, UnionSet):-
    append(Set1, Set2, All),    % append is a built-in predicate
    sort(All, UnionSet).        % sort is a built-in predicate (sorts and removes duplicates)


% 5
% gives_gift_to(Giver, Gift, Receiver)
gives_gift_to(bernardete, 'The Exchange', celestina).
gives_gift_to(celestina, 'The Brethren', eleuterio).
gives_gift_to(eleuterio, 'The Summons', felismina).
gives_gift_to(felismina, 'River God', juvenaldo).
gives_gift_to(juvenaldo, 'Seventh Scroll', leonilde).
gives_gift_to(leonilde, 'Sunbird', bernardete).
gives_gift_to(marciliano, 'Those in Peril', nivaldo).
gives_gift_to(nivaldo, 'Vicious Circle', sandrino).
gives_gift_to(sandrino, 'Predator', marciliano).

% 6
% unifies the second argument with the number of people who form the circle of gifts that includes the person received as first argument.
circle_size(Person, Size):-
    collect([Person], People),
    length(People, Size).

collect( [H|T], People):-
    gives_gift_to(H, _, N),
    \+ member(N, [H|T]), !,
    collect( [N,H|T], People).
collect(People, People).

% 7
:-use_module(library(lists)).
% unifies People with the list of people belonging to the largest circle in the book club.
largest_circle(People):-
    all_people(Everyone),
    setof(Size-Person-Sorted, Persons^(member(Person, Everyone), collect([Person], Persons), sort(Persons, Sorted), length(Sorted, Size)), Triples),
    last(Triples, MaxSize-_-_),
    setof(Persons,  P^member(MaxSize-P-Persons, Triples), LargestGroups),
    member(People, LargestGroups).

all_people(List):- 
    findall(X, (gives_gift_to(X, _, _) ; gives_gift_to(_, _, X)), Temp),
    sort(Temp, List).

% 8
% Verifica se X é uma variável não instanciada.

% 9
%findall(Template, Goal, List)
%Descrição: Coleta todas as soluções possíveis de Template que satisfazem Goal, e as coloca em List.

% setof(Template, Goal, List)
% Descrição: Coleta todas as soluções únicas de Template que satisfazem Goal, organiza-as em ordem crescente e as coloca em List.

% bagof(Template, Goal, List)
% Descrição: Coleta todas as soluções possíveis de Template que satisfazem Goal, mas organiza as soluções em grupos separados com base em valores diferentes de variáveis livres em Goal.

% 10
% converts a non-negative integer number Dec into a list of bits representing that number, using exactly N bits. If the number of bits is insufficient to represent the number, the predicate should fail.
dec2bin(Dec, BinList, N):-
    Dec >= 0,
	dec2bin(Dec, [], List, N).

dec2bin(0, List, List, 0):- !.
dec2bin(Dec, Acc, List, N):-
	N > 0,
	Bit is Dec mod 2,
	Next is Dec div 2,
	N1 is N - 1,
	dec2bin(Next, [Bit|Acc], List, N1).

% 11
% recebe um número decimal e o número de bits para o representar, bem como Padding - o número de zeros a adicionar de cada lado da representação binária resultante - devolvendo em List a lista de bits resultante
initialize(DecNumber, Bits, Padding, List):-
    dec2bin(Dec, Mid, N),
    dec2bin(0, Side, Padd),
    append([Side, Mid, Side], List).

% 12
% imprime no terminal uma representação textual de uma lista de bits, representando 0 como um ponto ('.'), 1 como um M maiúsculo ('M'), e separando cada byte (conjunto de 8 bits) com uma barra vertical ('|').
print_line(0, []):- !,
    write('|'), nl.
print_line(_, []):- !, nl.
print_line(0, Bits):- !,
    write('|'),
    print_line(8, Bits).
print_line(N, [Bit|Bits]):-
    N1 is N-1,
    translate(Bit, Char),
    put_char(Char),
    print_line(N1, Bits).

translate(0, '.').
translate(1, 'M').

print_generation(L):-
    write('|'),
    print_line(8, L).

% 13
% Predicado principal: atualiza as regras binárias com base no número dado.
update_rule(N):-
    \+ (dec2bin(N, Bits, 8)), !, fail. 
    % Verifica se a conversão do número N para uma lista binária de 8 bits é válida.
    % Se a conversão falhar (\+), o predicado falha (!, fail).
    
update_rule(N):- 
    dec2bin(N, Bits, 8), 
    % Converte o número N para uma lista de 8 bits chamada `Bits`.
    
    abolish(rule/2), 
    % Remove quaisquer definições anteriores do predicado `rule/2`.
    % Garante que as regras antigas sejam descartadas antes de criar novas.
    
    between(0, 1, FirstBit), 
    % Gera valores para `FirstBit` (0 ou 1).
    
    between(0, 1, SecondBit), 
    % Gera valores para `SecondBit` (0 ou 1).
    
    between(0, 1, ThirdBit), 
    % Gera valores para `ThirdBit` (0 ou 1).
    
    Index is 8 - (FirstBit * 4 + SecondBit * 2 + ThirdBit), 
    % Calcula o índice correspondente na lista de 8 bits. 
    % O índice é baseado em uma codificação binária dos três bits:
    %   Index = 8 - (4 * FirstBit + 2 * SecondBit + 1 * ThirdBit).
    % Por exemplo:
    %   Se FirstBit = 1, SecondBit = 0, ThirdBit = 1:
    %   Index = 8 - (1*4 + 0*2 + 1) = 3.
    
    nth1(Index, Bits, Bit), 
    % Obtém o valor do bit correspondente ao índice `Index` na lista `Bits`.
    % A função `nth1/3` usa índices baseados em 1 (não em 0).
    
    assert(rule(FirstBit-SecondBit-ThirdBit, Bit)), 
    % Define a nova regra no formato `rule(FirstBit-SecondBit-ThirdBit, Bit)`.
    % Por exemplo:
    %   Se FirstBit = 1, SecondBit = 0, ThirdBit = 1, e Bit = 1:
    %   Será gerado: rule(1-0-1, 1).
    
    fail. 
    % O `fail` força a backtracking para gerar todas as combinações possíveis
    % de `FirstBit`, `SecondBit` e `ThirdBit`, garantindo que todas as regras
    % sejam criadas para os 8 casos possíveis.

update_rule(_). 
% Predicado final que encerra o processo após a backtracking ser concluída.
% Esta regra é alcançada apenas depois que todas as combinações foram processadas.



% 14
% recebe uma lista de valores binários e calcula a geração seguinte, aplicando as regras existentes a cada posição. Os vizinhos em falta (para o primeiro e último elementos) são assumidos como sendo zeros.
next_gen(Previous, Next):-
    apply_rules(0, Gen0, Gen1).

apply_rules(Left, [Self], [New]):-
    rule(Left-Self-0, New).
apply_rules(Left, [Self, Right | Rest], [New | Tail]):-
    rule(Left-Self-Right, New),
    apply_rules(Self, [Right|Rest], Tail).

% 15
play(DecNumber, Bits, Padding, Rule, N):-
    initialize(Init, N, Padd, Gen0),
    update_rule(Rule),
    play_gens(Gens, Gen0).

play_gens(1, Gen):- !,
    print_generation(Gen).
play_gens(N, Gen0):-
    N1 is N -1,
    print_generation(Gen0),
    next_gen(Gen0, Gen1),
    play_gens(N1, Gen1).


