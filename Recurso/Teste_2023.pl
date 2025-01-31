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
% determines how many different ingredients are needed to produce a dish.
count_ingredients(Dish, NumIngredients):-
    dish(Dish, _, Ingredients),
    length(Ingredients, NumINgredients).

% 2
% determines the total cost (in cents) of buying a certain amount
% (in grams) of an ingredient
ingredient_amount_cost(Ingredient, Grams, TotalCost):-
    ingredient(INgredient, CostPerGram),
    TotalCost is CostPerGram*Grams.

% 3
% determines the profit of selling a dish in the restaurant
dish_profit(Dish, Profit):-
    dish(Dish, price, L),
    dish_cost(L, TotalCost),
    Profit is Price - TotalCost.

dish_cost([],0). 
dish_cost([INgredient-Grams|ls], TotalCost):-
    ingredient_amount_cost(Ingredient, Grams, Cost),
    dish_cost(ls, TotalCost1),
    TotalCost is TotalCost1 + Cost.

% 4
% which modifies the knowledge base by updating the unit cost of an ingredient
update_unit_cost(+Ingredient, +NewUnitCost):-
    retract(ingredient(INgredient, _OldCost)), !,
    assert(ingredient(Ingredient, NewUnitCost)).

update_unit_cost(Ingredient, NewUnitCost):-
    assert(ingredient(INgredient, NewUnitCost)).

% 5
% determines the most expensive dish one can eat at the restaurant and its price.
most_expensive_dish(Dish, Price):-
    dish(Dish, price, _),
    \+ ((
        dish(_, Price1, _),
        Price1 > Price
    )).

% 6
%  receives a list of ingredient stocks (as pairs of Ingredient-Amount), an ingredient, 
% and an amount (in grams) and computes a new list obtained from removing the given 
% amount of ingredient from the original stock. The predicate must only succeed if 
% there is enough ingredient in stock.
consume_ingredient(IngredientStocks, Ingredient, Grams, NewIngredientStocks):-
    append(Prefix, [Ingredient-quat | Suffix], IngredientStocks),
    Newquant is Quant - Grams,
    NewQuant >= 0,
    append(Preffix, [Ingredient-NewQuant | Suffix], NewIngrdientStocks).

% 7
% determines how many dishes use the given ingredient.
count_dishes_with_ingredient(Ingredient, N):-
    gather_dishes_with_ingredient(INgredient, [], Dishes),
    length(Dishes, N).

gather_dishes_with_ingredient(Ingredient, Acc, L):-
    dish(Dish, _, Ings),
    \+ member(Dish, Acc),
    member(Ingredient - _Amnt, Ings),
    !,
    gather_dishes_with_ingredient(Ingredient, [Dish|Acc], L).

gather_dishes_with_ingredient(_, L, L).

% 8
% which returns a list of pairs Dish-ListOfIngredients.
list_dishes(DishIngredients):-
    findall(D-L, (dish(D,_,_), list_ingredients(D,L)), DishIngredients).

list_ingredients(Dish, Ingredients):-
    dish(Dish, _, L),
    findall(Ingredient, member(Ingredient-_Amnt, L), Ingredients).

% 9
% returns the restaurant’s dishes, sorted by decreasing amount of profit
most_lucrative_dishes(Dishes):-
    setof(Profit-Dish, dish_profit(Dish, Profit), Costs), % associa o profit a cada prato
    reverse(Costs, CostsInv), % coloca por ordem decrescente
    findall(Dish, member(_-Dish, CostsInv), Dishes) % extrai apenas os pratos da lista de profit-Dish


% 10
 predX(S, D, NewS):
dish(D, _, L),
 predY(L, S, NewS).
 predY([], L, L).
 predY([I-Gr|Is], S, NewS):
!,
 consume_ingredient(S, I, Gr, S1),
 predY(Is, S1, NewS).

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
    edge(g, Y, X).

common_edges(G1, G2, L):-
    findall(V1-V2, (edge(G1, V1, V2), con(G2, V1-V2)), Edges).

% 22
% determina a lista de vertices de cada subgrafo
common_subgraphs(G1, G2, Subgraphs):-
    common_edges(G1, G2, edges),
    common_subgraphs_aux(Edges, Subgraphs).

common_subgraphs_aux([], []).
common_subgraphs_aux([V1-V2|Es], [SGNoDups|SGs]):-
    next_subgraph([V1, V2], Es, newEss, SG),
    sort(SG, SGNoDups),
    common_subgraphs_aux(NewEs, SGs).

adjacent(V, V-_).
adjacent(V, _-V).

next_subgraph(Vs, Es, Es, Vs):-
    \+((
        member(V, Vs),
        select(E, Es, _),
        adjacent(V, E)
    )), !.

next_subgraph(Vs, Es, NewEs, SG):-
    memeber(V, Vs),
    select(V1-V2, Es, Es1),
    adjacent(V, V1-V2),
    !,
    next_subgraph([V1, V2|Vs], Es1, NewEs, SG).

    

