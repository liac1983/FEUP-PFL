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
% Determina quantos ingredientes diferentes são necessários para cada prato
count_ingredients(Dish, NumIngredients):-
    % Procura o prato na base de dados
    dish(Dish, _, Ingredients),
    % Conta o número de ingredientes na lista 
    length(Ingredients, NumIngredients).

% 2 
% Determina o custo total (em centavos) de comprar uma quantidade de gramas de um ingrediente.
ingredient_amount_cost(Ingredient, Grams, TotalCost):-
    %Verifica o custo por grama do ingrediente
    ingredient(Ingredient, CostPerGram),
    %Calcula o custo total
    TotalCost is Grams * CostPerGram.

% 3
% Determina o lucro obtido ao vender um prato no restaurante
dish_profit(Dish, Profit):-
    % Verifica o prato e os ingredientes necessários
    dish(Dish, Price, IngredientGrams),
    % Calcula o custo total dos ingredientes
    total_ingredients_cost(IngredientGrams, TotalCost),
    % Calcula o lucro como a diferença entre o preço e o custo total
    Profit is Price - TotalCost.

% Calcula o custo total de uma lista de ingredients com quantidades especificas 
total_ingredients_cost([], 0). % Nenhum ingrediente
total_ingredients_cost([Ingredient-Grams | Rest], TotalCost):-
    % Calcula o custo do ingrediente atual
    ingredient_amount_cost(Ingredient, Grams, Cost),
    % Calcula o custo total dos ingredients restantes.
    total_ingredients_cost(Rest, RestCost),
    % Soma o custo atual ao custo restante
    TotalCost is Cost + RestCost.

% 4
% Atualiza o custo unitário de um ingrediente na base de dados
update_unit_cost(Ingredient, NewUnitCost):-
    % O ingrediente já existe na base de dados
    retract(ingredient(Ingredient, OldCost)), !,
    % Insere o novo fato com o custo atualizado na base de dados
    assert(ingredient(INgredient, NewUnitCost)).

update_unit_cost(Ingredient, NewunitCost):-
    % O ingrediente não existe na base de dados
    assert(ingredient(Ingredient, NewUnitCost)).


% 5
% Determina o prato mais caro do restaurante e o seu preço 
most_expensive_dish(Dish, Price):-
    % Obtém um prato e o seu preço na base de dados
    dish(Dish, Price,_),
    % Garante que não exista outro prato com preço maior
    \+ ((
        dish(_,Price1, _),
        Price1 > Price
    )).

% 6
% Recebe uma lista de ingredientes, e retorna uma nova lista com as qunatidades de ingredientes atualizada
consume_ingredient(IngredientStock, Ingredient, Grams, NewIngredientStocks):-
    % Divide a lista em 3 partes para encontrar o desejado
    append(Prefix, [Ingredient-Quant | Suffix], ingredientStocks),
    %Calcula a nova quantidade de ingrediente após o consumo
    NewQuant is Quant - Grams,
    % Verifica se a nova qunatidade é válida 
    NewQuant >= 0,
    % Reconstroi a lista de stock com a nova quantidade para o ingrediente
    append(Prefix, [Ingredient-NewQuant | Suffix], NewIngredientStocks).

% 7 
% Determina quantos pratos utilizam o ingrediente especificado 
count_dishes_with_ingredient(Ingredient, N):-
    % Recolhe todos os pratos que utilizam o ingrediente fornecido, iniciando com uma lista acumuladora vazia
    gather_dishes_with_ingredient(Ingredient, [], Dishes),
    % Conta o numero de pratos na lista resultante e atribui a N
    length(Dishes, N).

% Recolhe uma lista de pratos que utilizam o ingrediente especificado 
% Acc é uma lista acumuladora utilizada para evitar repetição de pratos
gather_dishes_with_ingredient(Ingredient, Acc, L):-
    % Tenta encontrar um prato e os seus ingredientes
    dish(Dish, _, Ings),
    % Garante que o prato ainda não foi adicionado à lista acumuladora
    \+ member(Dish, Acc),
    % Verifica se o ingrediente especificado está presente na lista de ingredients do prato
    member(Ingredient-_Amnt, Ings),
    %Após encontrar um prato, atualiza a lista acumuladora com o novo prato
    !, % O corte impede que Prolog continue buscando outras soluções para o mesmo prato
    % Chama recursivamente a função para continuar procurando outros pratos que contenham o ingrediente
    gather_dishes_with_ingredient(Ingredient, [Dish|Acc], L).

% quando não há mais para verificar a lista acumuladora se é igual à lista final
gather_dishes_with_ingredient(_, L, L).

% 8
% Retorna uma lista de pares no formato dish-lista de ingrediente
list_dishes(DishIngredients):-
    % Usa findall para construir uma lista de pares 
    findall(
        D-L,
        ( % Para cada prato D, gera a lista de ingredientes 
            dish(D, _,_),
            list_ingredients(D, L)
        ),
        DishIngredients % O resultado final é atribuido a DishIngredients.

    ).

% Retorna  alista de ingredientes usados para preparar um prato 
list_ingredients(Dish, INgredients):-
    % Recupera a lisat de ingredients e suas quantidades no prato
    dish(Dish, _, L),
    % Usa findall para extrair apenas os nomes dos ingredientes da lista L.
    findall(
        Ingredient,
        % Para cada para Ingrediente-Amount na lista L, pega apenas o nome do ingrediente
        member(Imgredient-_Amnt, L),
        Ingredients % A lista final de nomes dos ingredientes é atribuida a INgredients
    ).

% 9
% Retorna uma lisat de pratos ordenados pelo lucro em ordem decrescente
most_lucrative_dishes(Dishes):-
    % Usa setof para gerar uma lista de pares Profit-Dish
    % Ordem crescente
    setof(Profit-Dish, dish_profit(Dish, profit), Costs),
    % Reverte a lista ordenada para obter um alist em ordem decrescente de profit
    reverse(Costs, CostsInv),
    % Extrai apenas os nomes dos pratos da lista 
    % Usa findall para iterar sobre a lista e construir a lista final de dishes
    findall(Dish, member(_-Dish, CostsInv), Dishes).


    predX(S, D, NewS):-
	dish(D, _, L),
	predY(L, S, NewS).

predY([], L, L).
predY([I-Gr|Is], S, NewS):-
	!,
	consume_ingredient(S, I, Gr, S1),
	predY(Is, S1, NewS).

predZ:-
	read(X),
	X =.. [_|B],
	length(B, N),
	write(N), nl.

% 20
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

% 21
% Encontra as arestas comuns entre dois grafos
con(G, X-Y):-
    % Verifica se existe uma resta entre X e Y no grafo G
    edge(G, X, Y);
    edge(G, Y, X).

common_edges(G1, G2, Edges):-
    % Encontra as restas que satisfazem as seguintes condições 
    % existe no grafo G1
    % existe no grafo G2
    findall(V1-V2, 
        (edge(G1, V1, V2),
        con(G2, V1-V2)
        ),
        Edges).

% 22
% Determina a lista de vértices de cada subgrafo comum entre dois grafos
% A ordem dos subgrafos e dos vértices não é relevante
common_subgraphs(G1, G2, Subgraphs):-
    % Encontra as arestas comuns entre os grafos G1, G2
    common_edges(G1, G2, Edges),
    % Chama o predicado auxiliar para encontrar os subgrafos
    common_subgraphs_aux(Edges, Subgraphs).

common_subgraphs_aux([], []). % sem arestas, não há subgrafos
common_subgraphs_aux([V1-V2|Es], [SGNoDups|SGs]):-
    % Encontra o próximo subgrafo a partir da aresta V1-V2
    next_subgraph([V1,V2], Es, Newes, SG),
    % Remove duplicatas de vértices do subgrafo
    sort(SG, SGNoDups),
    % Chama recursivamente para encontrar os subgrafos restantes
    common_subgraphs_aux(NewEs, SGs).

adjacent(V, V-_). % Vértice V é adjacente a si memso através da aresta V-X
adjecent(V, _-V). % 

next_subgraph(Vs, Es, Es, Vs):-
    % não há mais vértices adjacentes
    \+((
        member(V, Vs), % Para cada vértice V no subgrafo atual
        select(E, Es, _), % Seleciona uma aresta E da lista de aresta restantes
        adjacent(V, E) % Verifica se V é adjacente a algum vertice da aresta 
    )), !. % Se não houver adjacencia, o subgrafo está completo

next_subgraph(Vs, es, NewEs, SG):-
    member(V, Vs), % Seleciona um vértice V do subgrafo atual
    select(V1-V2, Es, Es1), % Seleciona uma aresta V1-V2 da lista de arestas restantes
    adjacent(V, V1-V2), % Verifica se V é adjacente a algum vértice da aresta 
    !, % Corta para evitar soluções desnecessárias
    next_subgraph([V1, V2| Vs], Es1, NewEs, SG). % Adiciona os novos vértices ao aubgrafo e continua a busca 


