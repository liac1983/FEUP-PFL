% MT2 (18/1/2023)

% dish(Name, Price, IngredientGrams).
dish(pizza,         2200, [cheese-300, tomato-350]).
dish(ratatouille,   2200, [tomato-70, eggplant-150, garlic-50]).
dish(garlic_bread,  1600, [cheese-50, garlic-200]).

:- dynamic ingredient/2.

% ingredient(Name, CostPerGram).
ingredient(cheese,   4).
ingredient(tomato,   2).
ingredient(eggplant, 7).
ingredient(garlic,   6).

% 1
% Quantos ingredientes diferentes são necessários para produzir um prato
count_ingredients(Dish, NumIngredients):-
    dish(Dish, _Cost, L), % Associamos a lista de ingredientes de cada prato
    length(L,N). % obtemos o tamanho da lista de ingredientes e assim sabemos quantos ingredientes são necessários para cada prato

% 2
% quanto é que custam algumas gramas de um determinado ingrediente
ingredient_amount_cost(Ingredient, Grams, TotalCost):-
    ingredient(Ingredient, UnitCost), % obter o custo de 1 grama do ingrediente
    Cost is Grams * UnitCost. % calcular o custo de algumas gramas de um determinado ingrediente

% 3
% determina o lucro de vender um determinado prato no restaurante
dish_profit(Dish, Profit):-
    dish(Dish, Price, L), % obtemos o preço do prato
    dish_cost(L, TotalCost), % calcular o custo total para produzir o prato
    Profit is Price - TotalCost. % lucro

dish_cost([], 0). % se o prato não tiver ingredientes custa zero
dish_cost([Ingredient-Grams|Is], TotalCost):-
    ingredient_amount_cost(Ingredient, Grams, Cost), % custo de cada ingrediente no prato
    dish_cost(Is, TotalCost1), % fazer o mesmo para o resto da lista de ingredientes
    TotalCost is TotalCost1 + Cost. % custo total  de produzir o prato 

%4
% acrescenta à base de dados o preço de um determinado ingrediente
% se ele já existir atualiza apenas o seu preço
update_unit_cost(Ingredient, NewUnitCost):-
    retract(ingredient(Ingredient, _OldCost)), !, % tenta remover o ingrediente da base de dados 
    assert(ingredient(Ingredient, NewUnitCost)). % insere o ingrediente na base de dados e o seu custo associado

update_unit_cost(Ingredient, NewUnitCost):- 
    assert(ingredient(Ingredient, NewUnitCost)). % se o ingrediente não existir na base de dados acrescenta-o 

% 5
% retorna o prato mais caro e se houver mais que um com o esse preço retorna todos 
most_expensive_dish(Dish, Price):-
    dish(Dish, Price,_), % vamos buscar o nome do prato e o seu preço
    \+(( % negação em prolog
        dish(_, Price1, _), % obtemos o preço de outro prato
        Price1 > Price % comparamos os dois preços
    )).

% 6
% recebe uma lista com ingredientes e as suas gramas e verifica se eles existem 
% na base de dados, caso não existam continuam na lista inicial
consume_ingredient(IngredientStocks, Ingredient, Grams, NewIngredientStocks):-
    % divide a lista em 3 partes para encontrar o ingrediente desejado 
    append(Prefix, [Ingredient-quant | Suffix], IngredientStocks),
    % calcula  a nova qunatidade de ingredientes após o sonsumo
    Newquant is Quant - Grams,
    % verifica se a nova quantidade é valida
    NewQuant >= 0,
    % reconstroi a lista de stock com a nova quantidade para cada ingrediente
    append(Prefix, [Ingredient-NewQuant | Suffix], NewIngredientStocks).

% 7
% quantos pratos usam o seguinte ingrediente
count_dishes_with_ingredient(Ingredient, N):-
    gather_dishes_with_ingredient(Ingredient, [], Dishes), % obtém o nome dos pratos com o ingrediente
    length(Dishes, N). % calcula o tamanho da lista de pratos para obter o seu numero

gather_dishes_with_ingredient(Ingredient, Acc, L):-
    dish(Dish, _, Ings), % associa o prato com a lista de ingredientes
    \+ member(Dish, Acc), %garante que o prato ainda não está na lista acumuladora
    member(Ingredient - _Amnt, Ings), % verifica se o ingrediente está na lista de ingredientes do prato
    !, % o cut evita que o prolog procure mais soluções para este prato
    gather_dishes_with_ingredient(Ingredient, [Dish|Acc], L). % procura outros pratos com o mesmo ingrediente

gather_dishes_with_ingredient(_,L,L). % quando não há mais pratos a list acc é igual à lista final

% 8
% retorna uma lista com o prato-lista de ingredientes
list_dishes(DishIngredients):-
    findall(D-L,(dish(D,_,_), list_ingredients(D,L)), DishIngredients).

list_ingredients(Dish, Ingredients):-
    dish(Dish,_,L), % obter a lista de ingredientes associada a cada prato
    findall(Ingredient, member(Ingredient-_Amnt, L), Ingredients).
    % obter uma lista só com os ingredientes de cada prato uma vez que a lista anterior era ingrediente-quantidade

/*
findall(+Template, +Goal, -List)
Template: Forma dos elementos que serão incluídos na lista.
Goal: Condição ou objetivo para encontrar as soluções.
List: Lista resultante contendo os elementos correspondentes ao Template 
para os quais Goal é verdadeiro.
*/

% 9
% retorna os pratos do restaurante ordenados por ordem decrescente de lucro 
most_lucrative_dishes(Dishes):-
    setof(Profit-Dish, dish_profit(Dish, Profit), Costs), % associa o profit a cada prato
    reverse(Costs, CostsInv), % coloca por ordem decrescente
    findall(Dish, member(_-Dish, CostsInv), Dishes) % extrai apenas os pratos da lista de profit-Dish

/*
setof(+Template, +Goal, -Set).
Template: Define o formato dos elementos a serem coletados.
Goal: É a condição (ou predicado) que os elementos devem satisfazer.
Set: Contém o conjunto resultante, sem duplicatas e ordenado, que satisfaz o Goal.
*/

% 10

predX(S, D, NewS):-
	dish(D, _, L),
	predY(L, S, NewS).

predY([], L, L).
predY([I-Gr|Is], S, NewS):-
	!,
	consume_ingredient(S, I, Gr, S1),
	predY(Is, S1, NewS).


% 11
% cut green podes apagar o cut e o resultado é o mesmo
% cat red o contrario


% 12
predZ:-
	read(X),
	X =.. [_|B],
	length(B, N),
	write(N), nl.

% o utilizador escreve um termo e o pragrama dá o seu tamanho

% tail recursion
% implementar recursão onde a chamada recursiva é a última
% operação realizada por um predicado antes de retornar o resultado

% 14
% não conseguimos aceder ao primeiro elemento da lista com um predicado O(1)
% nem obter o comprimento da lista

% 15
garlic_bread requires cheese and garlic.
garlic_bread requires cheese and some garlic.
ratatouille requires tomato and eggplant and garlic.

% :- op(590, xfx, requires).

% Menor precedência significa que o operador tem menos prioridade na avaliação.

/*
fx: Operador prefixado (unário), o operador aparece antes de seu argumento.
fy: Também prefixado, mas permite precedência menor no argumento.
xf: Operador sufixado (unário), o operador aparece depois do argumento.
xfx: Operador infixado (binário), conecta dois argumentos.
yfx: Também infixado, mas permite precedência menor no primeiro argumento.
*/

% 17
% | ?- member(X, [a,b,c,d,e]), !, member(Y, [1,2,3,4]).

% por causa do cut só tem um filho
% 5 unifications

% 21
%G1
edge(g1, br, o).
edge(g1, br, ni).
edge(g1, o, ni).
edge(g1, o, c).
edge(g1, o, h).
edge(g1, h, c).
edge(g1, h, n).
edge(g1, n, he).
edge(g1, c, he).

% G2
edge(g2, br, h).
edge(g2, br, ni).
edge(g2, h, ni).
edge(g2, h, o).
edge(g2, h, c).
edge(g2, o, c).
edge(g2, o, n).
edge(g2, n, he).
edge(g2, c, he).
edge(g2, cl, he).

% Dado um grafo retorna os vertices conectados

con(G, X-Y):-
    edge(G, X, Y).

con(G, X-Y):-
    edge(G, Y,X).

common_edges(G1, G2, L):-
    findall(V1-V2, (edge(G1, V1, V2), con(G2, V1-V2)), Edges).

% 22
% determina a lista de vertices de cada subgrafo
common_subgraphs(G1, G2, Subgraphs):-
    common_edges(g1, G2, edges),
    common_subgraphs_aux(Edges, Subgraphs).

common_subgraphs_aux([],[]).
commmon_subgraphs_aux([V1-v2|Es], [SGNoDups|SGs]):-
    next_subgraph([V1,V2], Es, newEs, SG),
    sort(SG, SGNoDups), % remove duplicates
    common_subgraphs_aux(NewEs, SGs).

adjacent(V, V-_).
adjacent(V, _-V).

next_aubgraph(Vs, Es, Es, Vs):-
    \+((
        member(V, Vs),
        select(E, Es, _),
        adjacent(V, E)
    )), !.

next_subgraph(Vs, Es, NewEs, SG):-
    member(V, Vs),
    select(V1-V2, Es, Es1),
    adjacent(V, V1-V2),
    !,
    next_subgraph([V1, V2|Vs], Es1, NewEs, SG).







