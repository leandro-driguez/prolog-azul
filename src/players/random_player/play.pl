
:- ['../../pattern_lines/pattern_lines_management',
    '../../collections/collections_management',
    '../../tiles/tiles_management',
    '../../walls/walls_management',
    '../../factories/factory_Db',
    '../valid_move']
. 


choose(0, from_the_center_of_the_table).

choose(1, from_the_factories).


random_player_movement(_, Factory_index, 
        Tile, Pattern_lines_index
    ) :-

    random(0, 2, X),
    call(choose(X, Choose)),
    
    MetaPredicate_Choose=..[Choose, Factory_index, 
        Tile, Pattern_lines_index],
    call(MetaPredicate_Choose)
. 

from_the_factories(Factory_index, 
        Tile, Pattern_lines_index
    ) :-
    
    factories(Factories),
    number_of_factories(Number_of_factories),
    
    select_a_random_item_of_the_list(Factories, 
        Number_of_factories, Factory_index, Factory),

    select_a_random_item_of_the_list(Factory, 4, _, 
        Tile),

    random(0, 5, Pattern_lines_index)
. 

from_the_center_of_the_table(Factory_index, Tile, 
        Pattern_lines_index
    ) :-
    
    tiles_available(center_of_the_table, Tiles),

    Tiles = [],
    from_the_factories(Factory_index, Tile, 
        Pattern_lines_index), !
. 

from_the_center_of_the_table(Factory_index, Tile, 
        Pattern_lines_index
    ) :-
        
    tiles_available(center_of_the_table, Tiles),

    length_of_the_list(Tiles, Length),
    
    select_a_random_item_of_the_list(Tiles, Length, 
        _, Tile),

    random(0, 5, Pattern_lines_index),
    
    Factory_index = -1
. 
