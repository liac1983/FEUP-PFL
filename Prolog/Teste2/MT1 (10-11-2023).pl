:-dynamic saga/4, movie/8.

%saga(SagaID, Saga Name, Number of Movies in Saga, Creator)
saga(1, 'Jurassic Park',  6, 'Michael Crichton').
saga(2, 'Indiana Jones',  4, 'George Lucas').
saga(3, 'Star Wars',      9, 'George Lucas').
saga(4, 'Harry Potter',   0, 'J. K. Rowling').
saga(6, 'Jaws',           0, 'Peter Benchley').

%movie(Movie Title, Year of Release, SagaID, Duration, IMDB Score, Director, Composer, Cast)
movie('Jurassic Park',                  1993, 1, 127, 8.2, 'Steven Spielberg', 'John Williams',     ['Sam Neill', 'Jeff Goldblum', 'Laura Dern', 'BD Wong']).
movie('The Lost World: Jurassic Park',  1997, 1, 129, 6.5, 'Steven Spielberg', 'John Williams',     ['Jeff Goldblum', 'Julianne Moore', 'Vince Vaughn', 'Richard Schiff']).
movie('Jurassic Park III',              2001, 1,  92, 5.9, 'Joe Johnston',     'Don Davis',         ['Sam Neill', 'William H. Macy', 'Téa Leoni']).
movie('Jurassic World',                 2015, 1, 124, 6.9, 'Colin Trevorrow',  'Michael Giacchino', ['Chris Pratt', 'Bryce Dallas Howard', 'Irrfan Khan', 'BD Wong']).
movie('Jurassic World: Fallen Kingdom', 2018, 1, 128, 6.1, 'J.A. Bayona',      'Michael Giacchino', ['Chris Pratt', 'Bryce Dallas Howard', 'James Cromwell', 'BD Wong']).
movie('Jurassic World: Dominion',       2022, 1, 147, 5.6, 'Colin Trevorrow',  'Michael Giacchino', ['Chris Pratt', 'Bryce Dallas Howard', 'Campbell Scott', 'BD Wong']).

movie('Raiders of the Lost Ark',       1981, 2, 115, 8.4, 'Steven Spielberg', 'John Williams', ['Harrison Ford', 'Karen Allen', 'John Rhys-Davies']).
movie('The Temple of Doom',            1984, 2, 118, 7.5, 'Steven Spielberg', 'John Williams', ['Harrison Ford', 'Kate Capshaw', 'Ke Huy Quan']).
movie('The Last Crusade',              1989, 2, 127, 8.2, 'Steven Spielberg', 'John Williams', ['Harrison Ford', 'Alison Doody', 'Sean Connery']).
movie('Kingdom of the Crystal Skull',  2008, 2, 122, 6.2, 'Steven Spielberg', 'John Williams', ['Harrison Ford', 'Karen Allen', 'Shia LaBeouf']).

movie('The Phantom Menace',       1999, 3, 136, 6.5, 'George Lucas',     'John Williams', ['Ewan McGregor', 'Liam Neeson', 'Natalie Portman', 'Ian McDiarmid']).
movie('Attack of the Clones',     2002, 3, 142, 6.6, 'George Lucas',     'John Williams', ['Ewan McGregor', 'Hayden Christensen', 'Natalie Portman', 'Christopher Lee']).
movie('Revenge of the Sith',      2005, 3, 140, 7.6, 'George Lucas',     'John Williams', ['Ewan McGregor', 'Hayden Christensen', 'Natalie Portman', 'Christopher Lee']).
movie('A New Hope',               1977, 3, 121, 8.6, 'George Lucas',     'John Williams', ['Harrison Ford', 'Mark Hamill', 'Carrie Fisher', 'Alec Guinness']).
movie('The Empire Strikes Back',  1980, 3, 124, 8.7, 'Irvin Kershner',   'John Williams', ['Harrison Ford', 'Mark Hamill', 'Carrie Fisher', 'Billy Dee Williams']).
movie('Return of the Jedi',       1983, 3, 131, 8.3, 'Richard Marquand', 'John Williams', ['Harrison Ford', 'Mark Hamill', 'Carrie Fisher', 'Ian McDiarmid']).
movie('The Force Awakens',        2015, 3, 138, 7.8, 'J. J. Abrams',     'John Williams', ['Daisy Ridley', 'Harrison Ford', 'Mark Hamill', 'Carrie Fisher']).
movie('The Last Jedi',            2017, 3, 152, 6.9, 'Rian Johnson',     'John Williams', ['Daisy Ridley', 'Mark Hamill', 'Carrie Fisher', 'John Boyega']).
movie('The Rise of Skywalker',    2019, 3, 141, 6.4, 'J. J. Abrams',     'John Williams', ['Daisy Ridley', 'Mark Hamill', 'John Boyega', 'Adam Driver']).

% 1
% Verifica se os dois filmes pertencem à mesma saga
same_saga(Movie1, Movie2):-
    % Verifica se o primeiro filme pertence à base de dados e obtém o SagaID
    movie(Movie1, _Y1, SagaID, _D1, _I1, _Di1, _C1, _Cs1),
    % Verifica se Movie 2 pertence à base de dados
    movie(Movie2, _Y2, SagaID, _D2, _I2, _Di2, _C2, _Cs2),
    % Garante que Movie1, e Movie2 são filmes distintos 
    Movie1 \= Movie2.

% 2
% Relaciona o titulo de um filme com o nome da saga à qual ele pertence
movie_from_saga(Movie, Saga):-
    % Encontra o ID da saga e o nome na base de dados
    saga(SagaID, Saga, _N, _Creator),
    % Encontra o filme na base de dados com o mesmo Saga Id
    movie(Movie, _Y, SagaID, _Dur, _I, _D, _C, _Cs).

% 3
% Relaciona o nome da saga com o titulo do filme mais longo
saga_longest_movie(Saga, Movie):-
    % Encontra o ID da saga e o nome na base de dados
    saga(SagaID, Saga, _N, _Creator),
    % Procura o titulo do filme que pertence à saga ID correspondente
    movie(Movie, _Y1, SagaID, Dur, _IM1, _Dir1, _Comp1, _Cast1),
    % Nega a existencia de qualquer outro filme da mesma saga com maior duração
    \+((
        movie(_M2, _Y2, SagaID, D2, _IM2, _Dir2, _Comp2, _Cast2),
        D2 > Dur
    )).

% 4
% Adiciona um novo filme a uma saga
add_movie_to_saga(Saga, Movie, Year, Duration, Score, Director, Composer, Cast):-
    % Verifica se a saga com o nome especifico existe na base de dados
    saga(SagaID, Saga, _N, _C),
    % Verifica se o filme já está associado à saga
    movie(Movie, Year, SagaID, Duration, Score, Director, Composer, Cast),
    !,
    fail.

% Caso o filme ainda não exista, procede para adicionalo
add_movie_to_saga(Saga, Movie, Year, Duration, score, Director, Composer, Cast):-
    % Remove a saga atual da base de dados para poder atualiza-la
    retract(saga(SagaID, Saga, OldN, Creator)),
    % Incrementa a contagem de filmes na saga
    NewN is OldN + 1,
    % Reinsere a saga atualizada com o novo número de filmes
    assertz(saga(SagaID, Saga, NewN, Creator)),
    %  Adiciona o novo filme à base de dados 
    assertz(movie(Movie, year, SagaID, Duration, score, Director, Composer, Cast)).

% 5
% Retorna em Movies uma lista de todos os titulos de filmes da saga especifica ordenados pelo ano de lançamento
movies_from_sgaa(Sga, Movies):-
    % Verifica se a saga existe e obtém o SagaID correspondente
    saga(SagaID, Saga, _N, _C),
    % Chama um predicado auxiliar para reunir todos os filmes da saga com seus anos de lançamento
    movies_from_saga(SagaID, [], Movies).

% Reune os filmes da saga identificada acumulando pares Year-Movie
movies_from_saga(SagaID, Movies, Final):-
    % Obtém um filme da saga especifica e o seu ano 
    movie(Movie, Year, SagaID, _Dur, _Score, _Dir, _Comp, _Cast),
    % Verifica se o par Year-Movie ainda não está na lista acumulada
    \+ member(Year-Movie, Movies), !, % O corte impede backtrakng
    % Adiciona o par Year-Movie à lista acumulada e continua a busca recursiva
    movies_from_saga(SagaID, [Year-Movie | Movies], Final).

% quando não há mais fiomes para processar~
movies_from_saga(_SagaID, AllMovies, Movies):-
    % Ordena a lista acumulada AllMovies por ano
    sort(AllMovies, SortedMovies),
    % Remove os anos da lista ordenada para deixar apenas os titulos dos filmes
    remove_year(SortedMovies, Movies).

% Remove os anos dos pares Year-Movie na lista SortedMovies 
remove_year([],[]). % lista vazia resulta numa lista vazia
remove_year([_Y-Movie | T], [Movie | T2]):-
    % Remove o ano do par Year-Movie a aplica recursivamente ao restante da lista
    remove_year(T, T2).

% 6 
% Retorna em Cast uma lista de todos os atores que participam em filmes da saga especifica
saga_cast(Sga, cast):-
    % Verifica se a saga especificada existe e obtém o seu SagaId
    saga(SagaID, Saga, _N, _Cr),
    % Usa findall para reunir todos os atores do elenco de cada filme 
    % Para cada filme associado ao SagaId, obtémse o elenco Cast e os atores
    findall(
        Actor,
        (
            movie(_T, _Y, SagaID, _Dur, _Sc, _Dir, _Comp, Cast),
            member(Actor, cast)
        ),
        List % Lista contendo todos os atores 
    ),
    % Usa sort para ordenar a lista e remover duplicatas, gerando a lista final Cast
    sort(List, Cast).

% 7
% Retorna uma amostra de elenco de uma saga 
% Selecina apenas atores em posições impares 
sample_cast(Saga, SampleCast):-
    %Usa o predicado para obter a lista comppleta de atores 
    saga_cast(Saga, Cast),
    % Chama o predicado auxiliar sample para selecionar apenas os atores nas posições impares
    sample(Cast, SampleCast).

% Recebe uma lista de atores e retorna a os elemnetos nas posições impares
% Se a lista de entrada estiver vazia
sample([],[]).
% Se houver apenas um elemento na lista
sample([E], [E]).

% O primeiro elemento da lista é incluido na amostra
sample([A,_B|T], [A|T2]):-
    sample(T, T2).


% 8
% Unifica AvgScore com a pontuação media dos filmes para os quais o compositor escreveu a trilha sonora
composer_rating(Composer, AvgScore):-
    Usa findal para coletar todas as pontuações do sfilmes associados ao compositor
    findall(Score, movie(_M, _Y,_SID, _D, Score, _Dir, Composer, _Cs), Scores),
    % Calcula a numero total de filmes para os quais o compositor contribuiu
    length(Scores, len),
    % Soma todas as pontuações coletadas
    sumlist(Scores, Sum),
    % Calcula a pontuação média dividindo a soma total pelo numero de filmes 
    AvgScore is Sum / Len.

% 9
most_successful_composer(Composer1, Composer2, Composer1):-
    composer_rating(Composer1, R1),
    composer_rating(Composer2, R2),
    R1 >= R2, !.
most_successful_composer(_Composer1, Composer2, Composer2).

% 11
% Determina qual dos dois compositores fornecidos tem a maior pontuação media de filmes
most_successful_composer(Composer1, Composer2, Composer1):-
    % Obtém a pontuação média do primeiro compositor
    composer_rating(Composer1, S1),
    % Obtém a pontuação média do segundo compositor
    composer_rating(Composer2, S2),
    % Verifica se a pontuação média do primeiro compositor é maior ou igual à do segundo
    S1 >= S2.

most_successful_composer(Composer1, Composer2, Composer2):-
    % Obtém a pontuação média do primeiro compositor 
    composer_rating(Composer1, S1),
    % Obtém a pontuação média do segundo compositor
    composer_rating(Composer2, S2),
    % Verifica se a pontuação média do segundo compositor é igual ou maior que a do primeiro 
    S2 >= S1.

% 14
connected(Person1, Person2):-
    connected2(Person1, Person2),
    Person1 \= Person2.
connected(Person1, Person2):-
    connected2(Person2, Person1),
    Person1 \= Person2.
    
connected2(Person1, Person2):-
    movie(_T, _Y, _S, _D, _Sc, Person1, Person2, _).
connected2(Person1, Person2):-
    movie(_T, _Y, _S, _D, _Sc, Person1, _C, Cast),
    member(Person2, Cast).
connected2(Person1, Person2):-
    movie(_T, _Y, _S, _D, _Sc, _Dir, Person1, Cast),
    member(Person2, Cast).
connected2(Person1, Person2):-
    movie(_T, _Y, _S, _D, _Sc, _Dir, _Comp, Cast),
    member(Person1, Cast),
    member(Person2, Cast).

% Determines the degree of separation between Person1 and Person2
connected_degree(Person1, Person2, Degree):-
    % Start the breath-first search with the initial path
    connected_degree_bfs([[Person1]], Person2, Degree).


% Performs a breath-first search to find the shortest path between two people
% Queue is a list of paths to be explored.
connected_degree_bfs([[Person1| R]|_], Person1, Degree):- !,
    % i fthe first path in the queue reaches the target person
    % calculate the degree as the length of the path minus one
    length(R, Degree).

connected_degree_bfs([[Person1|R]|T], Person2, Degree):-
    % Generate all people directly connected to Person1 that haven't been visited yet
    setof(Next,
        (connected(Person1, Next),
        \+ member(Next, [Person1|R]) % Ensure the person is not already in the current path
        ),
        List),

    


    % Extend the current path for each new connection
    append_all(List, [person1|R], ToSee),
    % Add the newly extended paths to the queue for further exploration
    append(T, ToSee, NextList),
    % Recursively search the next level of connections
    connected_degree_bfs(NextList, Person2, Degree).

% For each connected person, create a new path by extending the current path
append_all([], _List, []). % No connections to extend
append_all([H|T], List, [H|List]NT):-
    % Extend the current path with the new connection H
    append_all(T, List, NT).

