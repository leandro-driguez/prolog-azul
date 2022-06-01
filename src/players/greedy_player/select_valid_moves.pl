
:- ['../../factories/factory_Db', 
    '../../tiles/center_of_the_table_Db', 
    '../../collections/collections_management']
. 

select_valid_moves(Movements) :-

    factories(Factories),
    
    select_valid_moves(Factories, Valid_moves),


    center_of_the_table(red, Amount_red),
    
    generate_list(Amount_red, red, List_red),
    
    concat(Valid_moves, [List_red], Valid_moves2),


    center_of_the_table(blue, Amount_blue),

    generate_list(Amount_blue, blue, List_blue),

    concat(Valid_moves2, [List_blue], Valid_moves3),


    center_of_the_table(green, Amount_green),

    generate_list(Amount_green, green, List_green),

    concat(Valid_moves3, [List_green], Valid_moves4),


    center_of_the_table(black, Amount_black),

    generate_list(Amount_black, black, List_black),

    concat(Valid_moves4, [List_black], Valid_moves5),


    center_of_the_table(yellow, Amount_yellow),

    generate_list(Amount_yellow, yellow, List_yellow),

    concat(Valid_moves5, [List_yellow], Valid_moves6),


    removes_matches(Valid_moves6, Valid_moves7),

    remove_empty(Valid_moves7, Movements) 
. 

select_valid_moves([], []):-!.

select_valid_moves([Factory|Rest_of_the_factories], Resulting_list):-
    
    select_valid_moves(Rest_of_the_factories, Resulting_rest),

    disjoin_set(Factory, Resulting_factory),

    concat(Resulting_factory, Resulting_rest, Resulting_list)

. 


disjoin_set([], []). 

disjoin_set(Factory, Resulting_list):-
    
    Factory = [Item|_],
    
    get_all_items_of_the_list(Factory, Item, Items, Rest),
    
    disjoin_set(Rest, Resulting_rest),

    concat([Items], Resulting_rest, Resulting_list)
. 
