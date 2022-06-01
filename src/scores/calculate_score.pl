
:- ['../walls/wall_Db', '../pattern_lines/pattern_line_Db',
    '../collections/collections_management',
    '../floor_lines/floor_line_Db', score_Db]
. 


calculate_player_score(Id_player, Score) :-
    
    wall(Id_player, Wall),
    pattern_line(Id_player, Pattern_line),
    
    calculates_the_score_of_the_pattern_line(Wall, 
        Pattern_line, Pattern_line_score),

    penalty_score(Id_player, Pattern_line_score, Score)
. 


penalty_score(Id_player, Score_without_penalty, Score_without_penalty):-    

    floor_line(Id_player, 0), !
. 

penalty_score(Id_player, Score_without_penalty, Score_with_penalty):-    

    floor_line(Id_player, Amount_of_tiles_on_the_floor_line),
    
    floor_line(Floor_line),

    Tmp is Amount_of_tiles_on_the_floor_line - 1,
    
    index_in_the_list(Floor_line, Tmp, Penalty),

    Score_with_penalty is Score_without_penalty + Penalty
.  


calculates_the_score_of_the_pattern_line(Wall, 
        [Pattern_line|[]], Score) :- 
    
    calculates_the_score_of_a_row_of_the_pattern_line(
        Wall, Pattern_line, Score
    ), !
. 

calculates_the_score_of_the_pattern_line(Wall, [Pattern_line|Rest_of_the_pattern_lines], Score) :-
    
    calculates_the_score_of_the_pattern_line(Wall, Rest_of_the_pattern_lines, Previous_score),
    
    calculates_the_score_of_a_row_of_the_pattern_line(Wall, Pattern_line, Current_score),

    Score is Current_score + Previous_score
. 


calculates_the_score_of_a_row_of_the_pattern_line(Wall, Pattern_line, Amount_of_adjacents) :-
     
    Pattern_line = [Color, Top, Top], 
    
    Row_index is Top - 1,
    
    wall(Tiled_wall),
    
    index_in_the_list(Tiled_wall, Row_index, Row),

    index_in_the_list(Row, Col_index, Color),

    move_next(Row_index, Col_index, Row_index_right, Col_index_right, right),

    go_as_far_as_you_can(Wall, Row_index_right, Col_index_right, right, Amount_right),


    move_next(Row_index, Col_index, Row_index_left, Col_index_left, left),

    go_as_far_as_you_can(Wall, Row_index_left, Col_index_left, left, Amount_left),

    Amount_moving_horizontally is Amount_right + Amount_left,


    move_next(Row_index, Col_index, Row_index_up, Col_index_up, up),
    
    go_as_far_as_you_can(Wall, Row_index_up, Col_index_up, up, Amount_up),
    

    move_next(Row_index, Col_index, Row_index_down, Col_index_down, down),

    go_as_far_as_you_can(Wall, Row_index_down, Col_index_down, down, Amount_down),

    Amount_moving_vertically is Amount_up + Amount_down,

    calculate_adjacents(Amount_moving_horizontally, Amount_moving_vertically, Amount_of_adjacents)
.  

calculates_the_score_of_a_row_of_the_pattern_line(_, Pattern_line, Amount_of_adjacents) :-
    
    Pattern_line = [_, Amount, Top], 
    
    Amount \= Top, Amount_of_adjacents = 0
. 


go_as_far_as_you_can(Wall, Row_i, Col_j, _, Amount_in_line) :- 
  
    not(is_valid(Wall, Row_i, Col_j)),

    Amount_in_line = 0, !
. 

go_as_far_as_you_can(Wall, Row_i, Col_j, _, Amount_in_line) :-
    
    index_in_the_matrix(Wall, Row_i, Col_j, 0),

    Amount_in_line = 0, !
. 

go_as_far_as_you_can(Wall, Row_i, Col_j, Direction, Amount_in_line) :-
    
    index_in_the_matrix(Wall, Row_i, Col_j, 1),

    move_next(Row_i, Col_j, Next_row_i, Next_col_j, Direction),

    go_as_far_as_you_can(Wall, Next_row_i, Next_col_j, Direction, New_amount_in_line),

    Amount_in_line is New_amount_in_line + 1, !
. 


% calculate the number of adjacent in line

calculate_adjacents(Amount_moving_horizontally, Amount_moving_vertically, Amount_of_adjacents) :-
    
    Amount_moving_horizontally \= 0, Amount_moving_vertically \= 0,

    Amount_of_adjacents is Amount_moving_horizontally + Amount_moving_vertically + 2, !
. 

calculate_adjacents(Amount_moving_horizontally, Amount_moving_vertically, Amount_of_adjacents) :-

    Amount_of_adjacents is Amount_moving_horizontally + Amount_moving_vertically + 1, !
. 
