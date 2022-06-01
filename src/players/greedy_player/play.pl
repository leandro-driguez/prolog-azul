
:- [generate_pattern_lines, select_valid_moves, 
    calculate_score, '../../walls/walls_management', 
    '../../collections/collections_management']
. 


greedy_player_movement(Id_player, Factories_index, Tile, 
        Pattern_lines_index
    ) :-
    
    select_valid_moves(Movements),
    
    greedy_player_move(Id_player, Tiles, 
        Pattern_lines_index, Movements, _),

    Tiles = [Tile|_],

    search_index(Tiles, Factories_index)
. 

greedy_player_move(_,empty,0,[],-100) :- !.

greedy_player_move(_,empty,0,[[]],-100) :- !.

greedy_player_move(Id_player, Tiles_Output, 
        Pattern_lines_index, Movements, Max
    ) :-

    Movements = [Tiles|Rest_of_the_tiles],

    get_max_pattern_line(Id_player, Tiles, 5, 
        Max_of_the_pattern_lines, Index_of_the_pattern_lines),

    greedy_player_move(Id_player, Tiles_of_the_rest, 
        Pattern_lines_index_of_the_rest, Rest_of_the_tiles, 
        Max_of_the_rest),
        

    get_max(Max_of_the_pattern_lines, Index_of_the_pattern_lines, 
        Tiles, Max_of_the_rest, Pattern_lines_index_of_the_rest, 
        Tiles_of_the_rest, Max, Pattern_lines_index, Tiles_Output)
. 


max_of_the_list([Max|[]], Max, 0).

max_of_the_list(List, Max, Index) :- 

    List = [First_item|Rest_of_the_list],

    max_of_the_list(Rest_of_the_list, Maxx, Indexx),

    Maxx > First_item,    

    Max = Maxx, Index is Indexx + 1
.  

max_of_the_list(List, Max, Index) :- 

    List = [First_item|Rest_of_the_list],

    max_of_the_list(Rest_of_the_list, Maxx, _),

    Maxx =< First_item,    

    Max = First_item, Index = 0
.  



get_max(Max_of_the_pattern_lines, Index_of_the_pattern_lines,
        Current_tiles,Max_of_the_rest,_,_,Max,Index, Tiles
    ) :-
    
    Max_of_the_pattern_lines > Max_of_the_rest,

    Max = Max_of_the_pattern_lines, 

    Index = Index_of_the_pattern_lines,
    
    Tiles = Current_tiles, !
. 

get_max(_,_,_,Max_of_the_rest,Index_of_the_rest, 
        Tiles_of_the_rest, Max, Index, Tiles
    ):-

    Max = Max_of_the_rest, 
    
    Index = Index_of_the_rest,
    
    Tiles = Tiles_of_the_rest, !
.




search_index(Tiles, Factories_index) :-

    factories(Factories),
    
    search_index(Tiles, Factories, 0, Factories_index)
. 


search_index(_, [], _, -1) :- !.

search_index(Tiles, [Factory|_], Factories_index_In, 
        Factories_index_Out
    ) :-
    
    select_valid_moves([Factory], Valid_moves),

    item_belongs_to_list(Tiles, Valid_moves),

    Factories_index_Out = Factories_index_In
. 

search_index(Tiles, [Factory|Rest_of_the_factories], 
        Factories_index_In, Factories_index_Out
    ) :-
    
    select_valid_moves([Factory], Valid_moves),

    not(item_belongs_to_list(Tiles, Valid_moves)),
    
    Tmp is Factories_index_In + 1,
    
    search_index(Tiles, Rest_of_the_factories, Tmp, 
        Factories_index_Out)
. 


get_max_pattern_line(_,_,0,-1000,-1) :- !. 

get_max_pattern_line(Id_player, Tiles, Amount_of_pattern_lines, 
        Max_of_the_pattern_lines, Index_of_the_pattern_lines
    ) :- 

    Pattern_line_index is Amount_of_pattern_lines - 1,
    get_max_pattern_line(Id_player, Tiles, Pattern_line_index, 
        Max_of_the_rest_pattern_lines, 
        Index_of_the_rest_pattern_lines),

    get_max_pattern_line_aux(Id_player, Tiles, Pattern_line_index, 
                                Max_of_the_rest_pattern_lines, 
                                Index_of_the_rest_pattern_lines, 
                                Max_of_the_pattern_lines, 
                                Index_of_the_pattern_lines)
. 


get_max_pattern_line_aux(Id_player, Tiles, Pattern_line_index, 
                        Max_of_the_rest_pattern_lines, 
                        Index_of_the_rest_pattern_lines, 
                        Max_of_the_pattern_lines, 
                        Index_of_the_pattern_lines
    ) :-

    wall(Id_player, Wall),

    generate_pattern_lines(Id_player, Tiles, Pattern_line_index, 
        Pattern_lines_Output, Rest_of_the_tiles),

    length_of_the_list(Rest_of_the_tiles, Length),
    
    calculate_score(Wall, Pattern_lines_Output, Score, Length),

    get_max(Score, Pattern_line_index, Tiles, 
            Max_of_the_rest_pattern_lines, 
            Index_of_the_rest_pattern_lines, 
            Tiles, Max_of_the_pattern_lines, 
            Index_of_the_pattern_lines, 
            Tiles), !
. 

get_max_pattern_line_aux(Id_player, Tiles, Pattern_line_index, 
        Max_of_the_rest_pattern_lines, Index_of_the_rest_pattern_lines, 
        Max_of_the_rest_pattern_lines, Index_of_the_rest_pattern_lines
    ) :-
   
    not(generate_pattern_lines(Id_player, Tiles, Pattern_line_index,_,_))
. 

get_max_pattern_line_aux(Id_player, Tiles, Pattern_line_index, 
        Max_of_the_rest_pattern_lines, _, Max_of_the_rest_pattern_lines, 
        Max_of_the_rest_pattern_lines
    ) :-

    generate_pattern_lines(Id_player, Tiles, Pattern_line_index, 
        _, Tiles), !
. 








% :- trace(search_index).
% :- trace(calculate_score).
% % :- trace(length_of_the_list).
% :- trace(get_max_pattern_line_aux).
% :- trace(get_max_pattern_line).
% :- trace(item_belongs_to_list).
% :- trace(greedy_player_movement).
% :- trace(greedy_player_move).
% :- trace(get_max).
% :- trace(generate_pattern_lines).
% :- trace(select_valid_moves).


