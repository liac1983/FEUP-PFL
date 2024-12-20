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

%1.a
/*add_person(Gender, Name) :-
    % Verifica se a pessoa já existe
    \+ male(Name),  % Não deve ser do gênero masculino
    \+ female(Name),  % Não deve ser do gênero feminino
    % Verifica o gênero e adiciona a pessoa apropriada
    ( Gender = male ->
        assertz(male(Name))  % Adiciona como masculino
    ; Gender = female ->
        assertz(female(Name))  % Adiciona como feminino
    ; fail  % Gênero inválido, falha
    ).
*/

add_person(male, Name):-
    \+ male(Name),
    assertz(male(Name)).

add_person(female, Name):-
    \+female(Name),
    assertz(female(Name)).

% 1.b
add_parents(Person, Parent1, Parent2):-
    \+parent(Parent1, Person),
    assertz(parent(Parent1, Person)).

add_parents(Person, Parent1, Parent2):-
    \+parent(Parent2, Person),
    assertz(parent(Parent2, Person)).

%1.c
remove_person:-
    read(Name),
    (male(Name)-> retract(male(Name));
    female(Name)-> retract(female(Name))),

    retractall(parent(Name, _)),
    retractall(parent(_, Name)).

% 1.d
% update_birthdates/0
% Atualiza os fatos de male/1 e female/1 para incluir o ano de nascimento.
update_birthdates :-
    update_male_birthdates,
    update_female_birthdates,
    write('All birthdates updated!'), nl.

% Atualiza todos os fatos male/1
update_male_birthdates :-
    male(Name),
    write('What is the year of birth of '), write(Name), write('? '), nl,
    read(Year),
    retract(male(Name)),  % Remove o fato antigo
    assertz(male(Name, Year)),  % Adiciona o fato atualizado
    fail.  % Força backtracking para processar o próximo fato
update_male_birthdates.  % Caso base: não há mais fatos para processar

% Atualiza todos os fatos female/1
update_female_birthdates :-
    female(Name),
    write('What is the year of birth of '), write(Name), write('? '), nl,
    read(Year),
    retract(female(Name)),  % Remove o fato antigo
    assertz(female(Name, Year)),  % Adiciona o fato atualizado
    fail.  % Força backtracking para processar o próximo fato
update_female_birthdates.  % Caso base: não há mais fatos para processar


%1.g
% print_descendents(+Person)
% Imprime os filhos e netos de uma pessoa no terminal.

print_descendents(Person) :-
    % Imprime os filhos
    write('Children:'), nl,
    parent(Person, Child),  % Encontra cada filho diretamente
    write(Child), nl,
    fail;  % Força backtracking para explorar todos os filhos
    true,  % Termina caso não haja mais filhos

    % Imprime os netos
    write('Grandchildren:'), nl,
    parent(Person, Child),  % Encontra cada filho
    parent(Child, Grandchild),  % Para cada filho, encontra os netos
    write(Grandchild), nl,
    fail;  % Força backtracking para explorar todos os netos
    true.  % Termina caso não haja mais netos

% 2.a

double(X, Y) :- Y is X * 2.

% map(+Pred, +List1, ?List2)
% Aplica Pred a cada elemento de List1 para gerar List2.
map(_, [], []).  % Caso base: lista vazia resulta em lista vazia.
map(Pred, [H1|T1], [H2|T2]) :-
    call(Pred, H1, H2),  % Aplica o predicado ao elemento atual.
    map(Pred, T1, T2).   % Processa recursivamente o restante da lista.


% 2.b
fold(_, FinalValue, [], FinalValue). 
fold(Pred, StartValue, [H|T], FinalValue) :-
    call(Pred, StartValue, H, Res),  % Aplica Pred ao acumulador e ao elemento atual
    fold(Pred, Res, T, FinalValue).  

sum(A,B, S):- S is A+B.

% 2.c
% separate(+List, +Pred, -Yes, -No)
% Separa os elementos de List em Yes (onde Pred é verdadeiro) e No (onde Pred é falso).
separate([], _, [], []).  % Caso base: lista vazia retorna duas listas vazias.
separate([H|T], Pred, [H|Yes], No) :-
    call(Pred, H),  % Verifica se Pred(H) é verdadeiro.
    separate(T, Pred, Yes, No).  % Continua separando o restante da lista.
separate([H|T], Pred, Yes, [H|No]) :-
    \+ call(Pred, H),  % Verifica se Pred(H) é falso.
    separate(T, Pred, Yes, No).  % Continua separando o restante da lista.


even(X) :- 0 =:= X mod 2.

% 2.d
% take_while(+Pred, +List, -Front, -Back)
% Divide a lista em Front (elementos que satisfazem Pred) e Back (restante).
take_while(_, [], [], []).  % Caso base: lista vazia resulta em duas listas vazias.
take_while(Pred, [H|T], [H|Front], Back) :-
    call(Pred, H),  % Verifica se Pred(H) é verdadeiro.
    take_while(Pred, T, Front, Back).  % Continua com a cauda da lista.
take_while(Pred, [H|T], [], [H|T]) :-
    \+ call(Pred, H).  % Quando Pred(H) é falso, interrompe e retorna o restante como Back.


% 2.e
% ask_execute/0
% Lê um objetivo da entrada do terminal e o executa.
ask_execute :-
    write('Insert the goal to execute'), nl,
    read(Goal),  % Lê o objetivo como entrada
    (   call(Goal)  % Tenta executar o objetivo
    ->  true  % Sucesso: retorna true
    ;   write('Failed to execute the goal.'), nl, fail  % Falha: informa ao usuário
    ).


% 3.a
% my_functor(+Term, ?Functor, ?Arity)
% Implementa a funcionalidade de functor/3 usando o operador =..
my_functor(Term, Functor, Arity) :-
    Term =.. [Functor | Args],  % Decomposição do termo
    length(Args, Arity).        % Calcula o número de argumentos

% 3.b
% my_arg(+Index, +Term, -Arg)
% Implementa a funcionalidade de arg/3 usando o operador =..
my_arg(Index, Term, Arg) :-
    Term =.. [_Functor | Args],  % Desconstrói o termo em [Functor | Args]
    nth1(Index, Args, Arg).      % Obtém o argumento na posição Index

%3.c
% univ(+Term, -List)
% Reproduz a funcionalidade de =.., decompondo ou compondo termos.
univ(Term, [Functor | Args]) :-
    functor(Term, Functor, Arity),  % Obtém o functor e a aridade do termo
    univ_args(Term, Arity, Args).   % Coleta os argumentos do termo

univ(Term, [Functor | Args]) :-
    length(Args, Arity),            % Determina a aridade pela quantidade de argumentos
    functor(Term, Functor, Arity),  % Constrói o termo com o functor e aridade
    univ_set_args(Term, Args, 1).   % Define os argumentos no termo

% univ_args(+Term, +Arity, -Args)
% Coleta os argumentos do termo.
univ_args(_, 0, []).
univ_args(Term, N, [Arg | Args]) :-
    N > 0,
    arg(N, Term, Arg),              % Obtém o N-ésimo argumento do termo
    N1 is N - 1,
    univ_args(Term, N1, Args).

% univ_set_args(+Term, +Args, +Index)
% Define os argumentos no termo a partir da lista de argumentos.
univ_set_args(_, [], _).
univ_set_args(Term, [Arg | Args], Index) :-
    arg(Index, Term, Arg),          % Define o argumento na posição Index
    Index1 is Index + 1,
    univ_set_args(Term, Args, Index1).

% 3.d

% Definição do operador infixo univ/2
:- op(500, xfx, univ).

% Implementação do univ/2 como predicado
univ(Term, [Functor | Args]) :-
    functor(Term, Functor, Arity),  % Obtém o functor e a aridade do termo
    univ_args(Term, Arity, Args).   % Coleta os argumentos do termo

univ(Term, [Functor | Args]) :-
    length(Args, Arity),            % Determina a aridade pela quantidade de argumentos
    functor(Term, Functor, Arity),  % Constrói o termo com o functor e aridade
    univ_set_args(Term, Args, 1).   % Define os argumentos no termo

% Coleta os argumentos do termo
univ_args(_, 0, []).
univ_args(Term, N, [Arg | Args]) :-
    N > 0,
    arg(N, Term, Arg),              % Obtém o N-ésimo argumento do termo
    N1 is N - 1,
    univ_args(Term, N1, Args).

% Define os argumentos no termo a partir da lista de argumentos
univ_set_args(_, [], _).
univ_set_args(Term, [Arg | Args], Index) :-
    arg(Index, Term, Arg),          % Define o argumento na posição Index
    Index1 is Index + 1,
    univ_set_args(Term, Args, Index1).


% 4.a
% tree_size(+Tree, -Size)
% Calcula o tamanho da árvore (número de nós).

% Caso base: uma folha tem tamanho 1.
tree_size(leaf(_), 1).

% Caso recursivo: um nó interno tem tamanho 1 + tamanho da subárvore esquerda + tamanho da subárvore direita.
tree_size(tree(_, Left, Right), Size) :-
    tree_size(Left, LeftSize),      % Calcula o tamanho da subárvore esquerda.
    tree_size(Right, RightSize),    % Calcula o tamanho da subárvore direita.
    Size is 1 + LeftSize + RightSize.  % Soma os tamanhos.

% 4.b
% tree_map(+Pred, +Tree, ?NewTree)
% Aplica Pred a cada valor de Tree e constrói NewTree com a mesma estrutura.

% Caso base: uma folha
tree_map(Pred, leaf(X), leaf(Y)) :-
    call(Pred, X, Y).  % Aplica Pred ao valor da folha.

% Caso recursivo: um nó interno
tree_map(Pred, tree(Value, Left, Right), tree(NewValue, NewLeft, NewRight)) :-
    call(Pred, Value, NewValue),       % Aplica Pred ao valor do nó atual.
    tree_map(Pred, Left, NewLeft),     % Aplica recursivamente à subárvore esquerda.
    tree_map(Pred, Right, NewRight).   % Aplica recursivamente à subárvore direita.


% 4.d
% tree_value_at_level(+Tree, ?Value, ?Level)
% Associa um valor na árvore com o nível em que ele está.

% Caso: Folha
tree_value_at_level(leaf(Value), Value, 0).  % Uma folha está no nível 0.

% Caso: Nó Interno
tree_value_at_level(tree(NodeValue, Left, Right), NodeValue, 0).  % O nó raiz está no nível 0.

% Caso: Subárvores (Valor na Subárvore Esquerda)
tree_value_at_level(tree(_, Left, _), Value, Level) :-
    tree_value_at_level(Left, Value, SubLevel),  % Procura o valor na subárvore esquerda
    Level is SubLevel + 1.  % Incrementa o nível

% Caso: Subárvores (Valor na Subárvore Direita)
tree_value_at_level(tree(_, _, Right), Value, Level) :-
    tree_value_at_level(Right, Value, SubLevel),  % Procura o valor na subárvore direita
    Level is SubLevel + 1.  % Incrementa o nível

% Caso: Valor Não Encontrado
tree_value_at_level(Tree, Value, -1) :-
    nonvar(Value),  % Só aplica se o valor foi especificado
    \+ tree_contains(Tree, Value).  % Valor não existe na árvore

% Verifica se um valor existe na árvore
tree_contains(leaf(Value), Value).
tree_contains(tree(Value, _, _), Value).
tree_contains(tree(_, Left, _), Value) :- tree_contains(Left, Value).
tree_contains(tree(_, _, Right), Value) :- tree_contains(Right, Value).


% 5

:-op(500, xfx, na). 
:-op(500, yfx, la). 
:-op(500, xfy, ra).

% 7
:-op(550, xf, class). 
:-op(560, xfx, of). 
:-op(570, xfx, on). 
:-op(560, xfx, at). 
:-op(550, xfy, :). 
:- op(500, xfx, from).

% 7.b
% Definir operadores
:- op(400, xfx, if).
:- op(300, xfx, then).
:- op(200, xfx, else).


% 8.a
% Definir o operador exists_in
:- op(500, xfx, exists_in).

% Implementar a relação exists_in
Element exists_in List :-
    member(Element, List).  % Verifica se Element é membro de List

% 8.b

% Definir os operadores
:- op(500, xfx, append).
:- op(400, xfx, to).
:- op(300, xfx, results_in).

% Implementar a relação
A append B to C results_in D :-
    append(A, B, Temp),
    append(Temp, C, D).  % Concatena A, B e C para formar D

% 8.c
% Definir os operadores
:- op(500, xfx, remove).
:- op(400, xfx, from).
:- op(300, xfx, results_in).

% Implementar a relação
Elem remove List from Result results_in Final :-
    select(Elem, Result, Temp),  % Remove Elem da lista Result, retorna Temp
    append(Temp, [], Final).     % Garante retorno Final 


% 9

% winning_move(+State, -Move)
% Recebe o estado do jogo (State) e retorna um movimento vencedor (Move),
% se houver, na forma move(Matches, Pile).
winning_move(State, move(Matches, Pile)) :-
    nim_sum(State, 0, Sum),           % Calcula a nim-sum do estado atual.
    Sum \= 0,                        % Se a nim-sum for 0, não há movimento vencedor.
    nth1(Pile, State, MatchesInPile),% Seleciona uma pilha para mover.
    MatchesToRemove is MatchesInPile xor Sum,  % Calcula o número de fósforos a remover.
    MatchesToRemove =< MatchesInPile, % O movimento deve ser válido.
    Matches is MatchesInPile - MatchesToRemove. % Número de fósforos restantes na pilha.

% nim_sum(+State, +Acc, -Sum)
% Calcula a nim-sum (XOR) de uma lista de números.
nim_sum([], Acc, Acc).  % Caso base: nenhuma pilha restante.
nim_sum([H | T], Acc, Sum) :-
    Temp is Acc xor H,  % Aplica XOR acumulado.
    nim_sum(T, Temp, Sum).

% 10.a

% Predicado principal
invert_predicate_clause_order :-
    write('Which predicate do you want to invert?'), nl,
    read(Predicate),
    (   functor(Predicate, Name, Arity) ->
        invert_clauses(Name, Arity),
        write('Predicate clauses inverted.'), nl
    ;   write('Invalid predicate input.'), nl, fail
    ).

% Inverte as cláusulas do predicado
invert_clauses(Name, Arity) :-
    findall(Clause, clause(Name/Arity, Clause), Clauses), % Coleta todas as cláusulas
    reverse(Clauses, InvertedClauses),                   % Inverte a ordem
    retractall(Name/Arity),                              % Remove as cláusulas existentes
    assert_inverted_clauses(Name, Arity, InvertedClauses). % Adiciona as invertidas

% Adiciona as cláusulas invertidas
assert_inverted_clauses(_, _, []).
assert_inverted_clauses(Name, Arity, [Clause | Rest]) :-
    assertz((Name/Arity :- Clause)), % Adiciona ao final das cláusulas do predicado
    assert_inverted_clauses(Name, Arity, Rest).

% 10.b

:- dynamic insert_clause_with_inverted_goals/0.

% Predicado principal
insert_clause_with_inverted_goals :-
    write('Insert a new predicate clause:'), nl,
    read(Clause),                       % Lê a cláusula do usuário
    Clause =.. [Head | Body],           % Decompõe a cláusula em cabeçalho e corpo
    reverse_goals(Body, InvertedBody),  % Inverte os objetivos no corpo
    NewClause =.. [Head | [InvertedBody]], % Reconstrói a cláusula com objetivos invertidos
    assertz(NewClause),                 % Adiciona a nova cláusula ao banco de conhecimento
    write('Clause inserted with inverted goals.'), nl.

% Inverte os objetivos no corpo de uma cláusula
reverse_goals(true, true) :- !.         % Caso base: sem objetivos (true).
reverse_goals((Goal1, Goal2), Inverted) :-
    !,
    reverse_goals(Goal1, Left),         % Processa recursivamente o lado esquerdo
    reverse_goals(Goal2, Right),        % Processa recursivamente o lado direito
    append(Right, Left, Combined),     % Junta na ordem inversa
    combine_goals(Combined, Inverted). % Combina os objetivos em uma lista
reverse_goals(Goal, [Goal]).           % Caso base: apenas um objetivo.

% Combina uma lista de objetivos em um termo Prolog
combine_goals([Goal], Goal).           % Caso base: apenas um objetivo.
combine_goals([Goal1, Goal2 | Rest], (Goal1, Combined)) :-
    combine_goals([Goal2 | Rest], Combined). % Combina recursivamente.



