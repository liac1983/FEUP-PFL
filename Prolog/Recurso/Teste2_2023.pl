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
% Conta quantos ingredientes são necessários para produzir cada prato 
count_ingredients(Dish, NumIngredients):-
    dish(Dish, _Cost, L), % Associa a lista de ingredientes de cada prato
    length(L, N). % obtemos o tamanho da lista de ingredientes e assim sabemos quantos ingredientes são necessários para cada prato

% 2
% quanto é que custa algumas gramas de um determinado ingrediente
ingredient_amount_cost(Ingredient, Grams, TotalCost):-
    ingredient(Ingredient, UnitCost), % obter o custo de 1 grama do ingrediente
    Cost is Grams * UnitCost. % calcular o custo de algumas gramas de um detreminado inrediente

% 3
% determina o lucro de veder um detreminado prato no restaurante
dish_profit(Dish, price, L):-
    dish(Dish, Price, L), % obtemos o preço do prato
    dish_cost(L, TotalCost), % calcular o custo total para produzir o prato
    Profit is Price - TotalCost. % Lucro

dish_cost([], 0). %se o prato não tiver ingredientes custa zero
dish_cost([INgredient-Grams|Is], TotalCost):-
    ingredient_amount_cost(Ingredient, Grams, Cost), % custo de cada ingrediente no prato
    dish_cost(Is,Totalcost1), % fazer o mesmo o resto da lista de ingredientes
    TotalCost is TotalCost1 + Cost. % custo total de produzir o prato

% 4
% acrescenta à base de dados o preço de um determinado ingrediente
% se ele já existir atualiza apenas o seu preço
update_unit_cost(Ingredient, NewUnitCost):-
    retract(ingredient(Ingredient, _OldCost)), !, % tenta remover o ingrediente da base de dados 
    assert(ingredient(Ingredient, NewUnitCost)). % insere o ingrediente na base de dados e o seu cuto associado 

update_unit_cost(Ingredient, NewUnitCost):-
    assert(ingrdeient(Ingredient, NewUnitCost)). % se o ingrediente não existir na base de dados acrescenta-o

% 5
% retorna o prato mais caro e se houver mais que um com esse preço retorna todos
most_expensive_dish(Dish, price):-
    dish(Dish, price, _), % vamos buscar o nome do prato e o seu preço
    \+(( % negação em prolog
        dish(_, price1, _), % obtemos o preço de outro prato
        Price1 > Price % comparamos os dois preços
        )).

% 6 
% recebe uma lista com ingredientes e as suas gramas e verifica se eles existem
% na base de dados, caso não existam continuam na lista inicial
consume_ingredient(IngredientStocks, Ingredient, Grams, NewIngredientStocks):-
    % divide a lista em 3 partes para encontrar o ingrediente desejado
    append(Prefix, [INgredient-Quant | Suffix], IngredientStocks),
    % calcula a nova quantidade de ingredientes após o consumo
    NewQuant is Quant - Grams,
    % erifica se a nova quantidade é valida
    NewQuant >= 0,
    % reconstroi a lista de stock com a nova quantidade para cada ingrediente
    append(Prefix, [Ingredient-NewQuant | Suffix], NewIngredientStocks).

% 7
% quantos pratos usam o seguinte ingrediente
count_dishes_with_ingredient(Ingredient, N):-
    gather_dishes_with_ingredient(Ingredient, [], Dishes), % obtém o nome dos pratos com o ingrediente
    length(Dishes, N). % calcula o tamnho d alista de pratos para obter o seu numero

gather_dishes_with_ingredient(Ingredient, Acc, L):-
    dish(Dish, _, Ings), % associa o prato com a lista de ingredientes
    \+ member(Dish, Acc), % garante que o prato ainda não está na lista acumuladora
    member(Ingredient- _Amnt, Ings), % verifica se o ingrediente está na lista de ingredientes do prato
    !, % o cut evita que o prolog procure mais soluções para este prato
    gather_dishes_with_ingredient(Ingredient, [Dish|Acc], L). % procura outros pratos com o mesmo ingrediente

gather_dishes_with_ingredient(_, L, L). % quanto não há mais pratos a lista acc é igual à lista final

% 8
% retorna uma lista com o prato-lista de ingredientes
list_dishes(DishINgredients):-
    findall(D-L, (dish(D, _, _), list_ingredients(D, L)), DishINgredients).

list_ingredients(Dish, Ingredients):-
    dish(Dish, _, L), % obter a lista de ingredientes associada a cada prato
    findall(Ingredient, member(Ingredient-Amnt, L), Ingredients).
    % obter uma lista só com os ingredientes de cada prato uma vez que a lista anterior era ingrediente-quantidade


% 9
% retorna os pratos do restaurante ordenados por ordem decrescente de lucro
most_lucrative_dishes(Dishes):-
    setof(Profit-Dish, dish_profit(Dish, Profit), Costs), % associa o profit a cada prato
    reverse(Costs, Costsinv), % coloca por ordem decrescente
    findall(Dish, member(_-Dish, CostsInv), Dishes) % extrai apenas os pratos da lista de profit-Dish

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

% dado um grafo retorna os vertices conectados
con(G, X-Y):-
    edge(G, X, Y).

con(G, X-Y):-
    edge(G, Y, X).

common_edges(G1, G2, L):-
    findall(V1-V2, (edge(G1, V1, V2), con(G2, V1-V2)), Edges).

% 22
% determnina a lista de vertices de cada subgrafo
common_subgraphs(G1, G2, Subgraphs):-
    common_edges(G1, G2, edges),
    common_subgraphs_aux(Edges, Subgraphs).

common_subgraphs_aux([], []).
common_subgraphs_aux([V1-V2|Es], [SGNoDups|SGs]):-
    next_subgraph([V1, V2], Es, newEs, SG),
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



