% Teste Prolog 2024

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
    author(AuthID, Author, _YearOfBirth, _CountryOfBirth),
    book(Title, AuthID, _YearOfRelease, _Pages, _Genres).

% 2
% unifies Title with the title of a book that has multiple genres
multi_genre_book(Title):-
    book(Title, _AuthID, _Year, _Pages, Genres),
	length(Genres, Len),                        % length is a built-in predicate
	Len > 1.


% 3
% which receives two book titles as arguments and 
% returns on the third argument a list containing 
% the genres that are common to both books. 
shared_genres(Title1, Title2, CommonGenres):-
    book(Title1, _ID1, _Year1, _Pages1, Genres1),
    book(Title2, _ID2, _Year2, _Pages2, Genres2),
    common_elements(Genres1, Genres2, CommonGenres).

% Determine common elements between two lists
common_elements([], _L, []).
% Se o primeiro elemento da primeira lista estiver presente na segunda lista,
% ele é adicionado à lista de resultado e a recursão continua.
common_elements([H|T], L, [H|R]):-
    member(H,L), !, % O operador de corte (!) impede que Prolog tente outras soluções.
    common_elements(T, L, R).
% Se o primeiro elemento da primeira lista não estiver na segunda lista,
% ele é ignorado e a recursão continua com o restante da lista.
common_elements([_|T], L, R):-
    common_elements(T, L, R).

% 4
% which determines the Jaccard coefficient between the two books received as first 
% two arguments, considering the genres of each book
similarity(Title1, Title2, Similarity):-
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
% which unifies the second argument with the number of people who form the circle 
% of gifts that includes the person received as first argument
circle_size(Person, Size):-
    collect([Person], People), % coleciona a lista de pessoas no ciclo
    length(People, Size).

collect([H|T], People):-
    gives_gift_to(H, _, N),
    \+ member(N, [H|T]), !, % verifica se o N já não está na lista se não fica um ciclo infinito 
    collet([N,H|T], People). % adiciona H na lista de pessoas no ciclo
collect(People, People). %  Quando não há mais novas conexões a serem exploradas, retorna a lista final de pessoas no círculo.

% 7
% unifies People with the list of people belonging to the largest circle in the 
% book club.
largest_circle(People):-
    all_people(Everyone),
    setof(Size-Person-Sorted, Person^(member(Person, Everyone), collect([Person], Person), sort(Persons, Sorted), length(Sorted, Size)), Triples),
    last(Triples, MaxSize-_-_),
    setof(Persons, P^member(MaxSize-P-Persons, Triples), LargestGroups),
    member(People, LargestGroups).

all_people(List):-
    findall(X, (gives_gift_to(X, _, _); gives_gift_to(_,_,X)), Temp),
    sort(Temp, List).

% 10 
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
% receives a decimal number and number of bits in which to represent it, as well
% as Padding - the number of zeroes to place on each side
initialize(DecNumber, Bits, Padd, List):-
    dec2bin(Dec, Mid, N),
    dec2bin(0, Side, Padd),
    append([Side, Mid, Side], List).

% 12
% prints to the terminal a text representation of a list of bits, representing 0 as 
% a dot ('.'), 1 as a capital M ('M'), and separating each byte (set of 8 bits) with
% a pipe ('|'). 
print_line(0, []):- !, % Quando o contador chega a 0 e a lista está vazia, imprime uma barra ('|') e pula para a próxima linha.
    write('|'), nl.
print_line(_, []):- !, nl. % Se a lista de bits estiver vazia, apenas pula para a próxima linha.
% Quando o contador chega a 0 mas ainda há bits na lista,
% imprime uma barra ('|') e reinicia o contador para 8.
print_line(0, Bits):- !,
    write('|'),
    print_line(8, Bits).
% Processa um bit por vez da lista.
print_line(N, [Bit|Bits]):-
    N1 is N-1,
    translate(Bit, Char),
    put_char(Char),
    print_line(N1, Bits).

translate(0, '.').
translate(1, 'M').

% Predicado principal que imprime uma linha de células.
print_generation(L):-
    write('|'),
    print_line(8, L).

% 13
% Predicado update_rule/1 que recebe um número decimal N e o converte para uma regra binária de 8 bits.
update_rule(N):-
    \+ (dec2bin(N, Bits, 8)), !, fail. % Se a conversão de N para binário falhar, retorna falso.
update_rule(N):-
    dec2bin(N, Bits, 8), % Converte o número N para uma lista de 8 bits.
    abolish(rule/2), % Remove quaisquer regras anteriores definidas com rule/2.
     % Gera todas as combinações possíveis de três bits (000 a 111).
    between(0,1, FirstBit),
    between(0,1,SecondBit),
    between(0,1,ThirdBit),
    % Calcula o índice correspondente na lista de bits.
    Index is 8 - (FirstBit * 4 + SecondBit * 2 + ThirdBit),
    % Obtém o bit correspondente no índice calculado.
    nth1(Index, Bits, Bit),
    % Armazena a regra associando a combinação de bits ao bit correspondente.
    assert(rule(FirstBit-Second-ThirdBit, Bit)),
    fail.
update_rule(_).


% 14 
% recebe uma lista de valores binários e calcula a geração seguinte, aplicando
% as regras existentes a cada posição. Os vizinhos em falta (para o primeiro e
% último elementos) são assumidos como sendo zeros.
next_gen(Gen0, Gen1):-
    apply_rules(0, Gen0, Gen1). % Chama apply_rules/3, assumindo que a célula mais à esquerda tem valor 0.
% Quando a lista contém apenas uma célula, aplica a regra correspondente.
apply_rules(Left, [Self], [New]):-
    rule(Left-Self-0, New). % Aplica a regra para a última célula, considerando 0 à direita.
% Aplica a regra a cada célula da geração atual.
apply_rules(Left, [Self, Right | Rest], [New | Tail]):-
    rule(Left-Self-Right, New), % Obtém a nova célula com base na regra definida.
    apply_rules(Self, [Right|Rest], Tail). % Chama recursivamente para processar o restante da lista.

% 15
% Este predicado deve orquestrar as chamadas aos predicados existentes e imprimir 
% as primeiras N gerações no terminal.
play(Init, N, Padd, Rule, Gens):-
    initialize(Init, N, Padd, Gen0), % Inicializa a primeira geração Gen0 com padding (Padd).
    update_rule(Rule), % Atualiza a regra do autômato celular com base no número Rule.
    play_gens(Gens, Gen0). % Inicia a simulação chamando play_gens/2.
% % Gera e imprime as sucessivas gerações do autômato celular.
play_gens(1, Gen):- !, % Se restar apenas 1 geração a ser exibida, imprime e finaliza a execução.
    print_generation(Gen).
play_gens(N, Gen0):- % Processa N gerações do autômato.
    N1 is N -1,
    print_generation(Gen0),
    next_gen(Gen0, Gen1),
    play_gens(N1, Gen1).

