%MT1 (10/11/2023)

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
% retorna true se dois filmes pertencem à mesma saga
same_saga(Movie1, Movie2):-
    % associa o filme 1 e o filme 2 à mesma saga
    movie(Movie1, _Y1, SagaID, _D1, _I1, _Di1, _C1, _Cs1),
    movie(Movie2, _Y2, SagaID, _D2, _I2, _Di2, _C2, _Cs2),
    Movie1 \= Movie2.

% 2
% relaciona o titulo do filme com o nome da saga
movie_from_saga(Movie, Saga):-
    % no filme e na saga o SagaID têm o mesmo valor 
    % o pertendemos obter é i movie e a saga
    saga(SagaID, Saga, _N, _Creator),
    movie(Movie, _Y, SagaID, _Dur, _I, _D, _C, _Cs).

% 3
% relaciona o nome da saga com o titulo do filme 
% obtém o filme com a duração mais alta na saga
saga_longest_movie(Saga, Movie):-
    % relaciona o titulo de filme com o nome da saga
    saga(SagaID, Saga, _N, _Creator),
    movie(Movie, _Y1, SagaID, Dur, _IM1, _Dir1, _Comp1, _Cast1),
    % negação quando falha
    \+(( movie(_M2, _Y2, SagaID, D2, _IM2, _Dir2, _Comp2, _Cast2), D2 > Dur)).

% 4
% Adiciona um filme novo à saga
add_movie_to_saga(Saga, Movie, Year, Duration, Score, Director, Composer, Cast):-
    saga(SagaID, Sga, _N, _C),
    movie(Movie, Year, SagaID, Duration, Score, Director, Composer, Cast), !, fail.

% se a saga do filme já existe também tem que ser atualizada
add_movie_to_saga(Saga, Movie, Year, Duration, Score, Director, Composer, Cast):-
    retract(saga(SagaID, Saga, OldN, Creator)), % remover uma saga da base de dados
    NewN is OldN + 1,
    assertz(saga(SagaID, Saga, NewN, Creator)), % adicionar uma saga
    assertz(movie(Movie, Year, SagaID, Duration, score, Director, Composer, cast)). % adiconar um filme


% 5
% retorna os filmes de uma saga ordenados pelo ano que foram feitos
movies_from_saga(Saga, Movies):-
    saga(SagaID, Saga, _N, _C), % todos os filmes têm o mesmo SagaID
    movies_from_saga(SagaID, [], Movies). % enontrar os filmes que pertencem á mesma saga

movies_from_saga(SagaID, Movies, Final):-
    movie(Movie, Year, SagaID, _Dur, _Score, _Dir, _Comp, _Cast),
    \+member(Year-Movie, Movies), !,  %não adiciona à lista se o filme não pertencer à mesma saga
    movies_from_saga(SagaID, [Year-Movie|Movies], Final).

movies_from_saga(_SagaID, AllMovies, Movies):-
    sort(AllMovies, SortedMovies), % ordena os filmes 
    remove_year(SortedMovies, Movies).

remove_year([],[]). % se a lista de filmes estiver vazia continua vazia
remove_year([_Y-Movie | T], [Movie |T2]):-
    remove_year(T,T2).

% 6
% retorna em Cast uma lista de actores que participaram nos filmes da saga sem duplicar 
saga_cast(Saga, Cast):-
    saga(SagaID, Saga, _N, _Cr),
    % encontra um actor que pertence a um filme cuja sagaID é igual 
    findall(Actor, (movie(_T, _Y, SagaID, _Dur, _Sc, _Dir, _Comp, Cast), member(Actor, Cast)), List),
    sort(List, Cast). % ordena a lista 

% 7
% o mesmo da anterior, mas só os atores em posições impares
sample_cast(Saga, Cast):-
    saga_cast(Saga, Cast), % para obter os atores que pertencem a uma saga  
    sample(Cast, SampleCast).

sample([], []). % se não houver atores retorna lista vazia
sample([E], [E]). % se só houver um retorna 1 
sample([A,_B|T], [A|T2]):- % se houver mais que um 
    sample(T, T2). % passa o segundo à frente e faz o mesmo

% 8
% para quantos filmes é que o compositor compos musica
composer_rating(Composer, AvgScore):-
    findall(Score, movie(_M, _Y, _SID, _D, Score, _Dir, Composer, _Cs), Score), % associa o score ao compositor
    length(Scores, Len), % quantos scores
    sumlist(Scores, Sum), % a soma dos scores
    AvgScore is Sum / Len. % a média dos scores

% 9
% qual o melhor de dois compositores
/*most_successful_composer(Composer1, Composer2, Composer1):-
    composer_rating(Composer1, R1),
    composer_rating(Composer2, R2),
    R1 >= R2, !.
most_successful_composer(_Composer1, Composer2, Composer2).*/

% como o terceiro argumento é igual ao segundo o programa é 
% sempre bem sucedido, mas não dá o resultado correto

% red cut, se retirarmos dá resultado diferente


most_successful_composer(Composer1, Composer2, Composer1):-
    composer_rating(Composer1, S1),
    composer_rating(Composer2, S2),
    S1 >= S2.

most_successful_composer(Composer1, Composer2, Composer2):-
    composer_rating(Composer1, s1),
    composer_rating(Composer2, s2),
    S2 >= S1.

% 13
Composer composed_for Movie:-   
    movie(Movie, _Year, _Saga, _Dur, _Score, _Dir, Composer, _Cast).

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

% retorna o grau de separação emtre duas pessoas (numero minimo de conecções num grafo)
connected_degree(Person1, Person2, Degree):-
    connected_degree_bfs([Person1], Person2, Degree).

connected_degree_bfs([[Person1|R]|_], Person1, Degree):- !,
    length(R, Degree).

connected_degree_bfs([[Person1|R]|T], Person2, Degree):-
    setof(next, (connected(Person1, next),
                \+ (member(Next, [Person1|R]))), List),
    append_all(List, [Person1|R], ToSee),
    append(T, ToSee, NextList),
    connected_degree_bfs(NextList, person2, Degree).

append_all([], _List, []).
append_all([H|T], List, [[H|List]|NT]):-
    append_all(T, List, NT).

    

