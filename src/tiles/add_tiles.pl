
:- ['../utils/utils'].


add_tiles(_,[]) :- !.


add_tiles(Predicate, [Tile|Rest_of_tiles]):-
  
    addition(Predicate, Tile, 1),
    
    add_tiles(Predicate, Rest_of_tiles)
. 
