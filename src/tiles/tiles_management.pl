
:- [add_tiles, get_tiles, center_of_the_table_Db, 
    box_cover_Db, bag_Db, tiles_available, generate_Db,
    tiles_Db]
. 

:-op(150, xfx, [from_the, to_the]).
:-op(150, xfy, [of]).
:-op(150, fy, [add, get]).


add Tiles to_the Predicate :-
    
    Tiles = [Tile|Rest_of_tiles],
    
    add_tiles(Predicate, [Tile|Rest_of_tiles])
.    


get Amount of Tile from_the Predicate :-
    
    get_all_tiles(Predicate, Tile, Amount)
. 
