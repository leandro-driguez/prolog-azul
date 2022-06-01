
:- ['../utils/utils'].


tiles_available(Predicate, Tiles):-
   
    tiles_available(Predicate, [black, blue, 
        red, yellow, green], Tiles)
. 


tiles_available(_,[],[]) :- !.


tiles_available(Predicate, [Tile |
        Rest_of_the_tiles], Tiles
    ):-
   
    MetaPredicate=..[Predicate, Tile, Value],
    
    call(MetaPredicate),
    
    Value > 0,
    
    tiles_available(Predicate, Rest_of_the_tiles,
        New_tiles),

    Tiles = [Tile|New_tiles], !
.  


tiles_available(Predicate, [Tile |
        Rest_of_the_tiles], Tiles
    ):-
   
    MetaPredicate=..[Predicate, Tile, Value],
    
    call(MetaPredicate),
    
    Value =< 0,
    
    tiles_available(Predicate, Rest_of_the_tiles,
        Tiles)
.  



