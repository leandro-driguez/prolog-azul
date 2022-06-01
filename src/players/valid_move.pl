
:- ['../collections/collections_management',
    '../walls/walls_management']
. 


is_a_valid_move(Tile,[[Tile,Amount,Top]|_],_) :-
    
    Amount \= Top, !
. 

is_a_valid_move(Tile,[[empty,_,Top]|_],Wall):- 

    Row_index is Top - 1,
    
    wall(Tiled_wall),
    
    index_in_the_list(Tiled_wall, Row_index, Row),
    
    index_in_the_list(Row, Col_index, Tile),

    index_in_the_matrix(Wall, Row_index, Col_index, 0), !
. 

is_a_valid_move(Tile,[_|Rest_of_the_pattern_lines],
    Wall):- 
    
    Rest_of_the_pattern_lines \= [],

    is_a_valid_move(Tile,Rest_of_the_pattern_lines,
    Wall), !
. 
