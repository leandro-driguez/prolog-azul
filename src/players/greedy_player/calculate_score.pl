
:- ['../../collections/collections_management',
    '../../floor_lines/floor_lines_management',
    '../../scores/scores_management']
. 


calculate_score(Wall, Pattern_lines, Score,
        Amount_of_tiles_on_the_floor_line
    ):-
    Amount_of_tiles_on_the_floor_line > 0,
    
    calculates_the_score_of_the_pattern_line(Wall, 
        Pattern_lines, Pattern_lines_score),
    

    Tmp is Amount_of_tiles_on_the_floor_line - 1,
    
    floor_line(Floor_line),
    
    index_in_the_list(Floor_line, Tmp, Penalty),

    Score is Pattern_lines_score + Penalty, !
. 

calculate_score(Wall, Pattern_lines, Score, 
        Amount_of_tiles_on_the_floor_line
    ):-

    Amount_of_tiles_on_the_floor_line =< 0,
    
    calculates_the_score_of_the_pattern_line(Wall, 
        Pattern_lines, Score), !
. 
