
:- ['../collections/collections_management',
    wall_Db]
. 


set_wall(Wall, Wall, []) :- !.

set_wall(Wall, Modified_wall, [[Tile, Row_index]]) :-

    wall(Tiled_wall),
    
    index_in_the_list(Tiled_wall, Row_index, Row),
    
    index_in_the_list(Row, Col_index, Tile),
    
    assign_into_matrix(Wall, Modified_wall, 
        Row_index, Col_index, 1), !
. 

set_wall(Wall, Modified_wall, [Tiles|Rest_of_the_tiles]) :-

    set_wall(Wall, Rest_modified_wall, Rest_of_the_tiles),
    
    Tiles = [Tile, Row_index],
    
    wall(Tiled_wall),
    
    index_in_the_list(Tiled_wall, Row_index, Row),
    
    index_in_the_list(Row, Col_index, Tile),
    
    
    assign_into_matrix(Rest_modified_wall, Modified_wall, 
        Row_index, Col_index, 1), !
.

set_wall_transducer(MetaPredicate, MetaPredicate_Modified, 
        [Tiles]
    ) :-

    MetaPredicate=..[wall,Id_player, Wall],
    
    call(MetaPredicate),
    
    
    set_wall(Wall, Modified_wall, Tiles), 
    
    MetaPredicate_Modified=..[wall,Id_player, Modified_wall]
. 

set_wall(Id_player, Tiles) :- 

    MetaPredicate=..[wall,Id_player, _],
    
    call(MetaPredicate),
    
    transducer(MetaPredicate, set_wall_transducer, 
        [Tiles])
. 
