:- ['../utils/utils'].


get_all_tiles(Predicate, Tile, Amount):-
   
    Predicate has Tile available,

    MetaPredicate=..[Predicate,Tile,Amount], 
    
    call(MetaPredicate),

    addition(Predicate, Tile, -Amount), !
. 


get_all_tiles(Predicate, Tile, Amount):-
   
    Predicate does_not_have Tile available,
    Amount = 0
.  
