
:- ['../scores/scores_management'].


update_final_game_score(0, _) :- !.

update_final_game_score(Amount_of_players, Stream) :-

    Id_player is Amount_of_players - 1,
    update_final_game_score(Id_player, Stream),

    write(Stream,'            Jugador '), write(Stream,Amount_of_players), write(Stream,'\n\n'),

    wall(Id_player, Wall),

    completed_a_row(Wall, 5, Amount_of_completed_rows),

    write(Stream,' ---> Cantidad de filas completadas: '), write(Stream,Amount_of_completed_rows), write(Stream,'\n\n'),

    completed_a_col(Wall, 5, Amount_of_completed_cols),

    write(Stream,' ---> Cantidad de columnas completadas: '), write(Stream,Amount_of_completed_cols), write(Stream,'\n\n'),

    completed_a_tile(Wall, 5, Amount_of_completed_tiles),

    write(Stream,' ---> Cantidad de azulejos completados: '), write(Stream,Amount_of_completed_tiles), write(Stream,'\n\n'),

    Final_score is Amount_of_completed_tiles * 10 +
                   Amount_of_completed_cols * 7 +
                   Amount_of_completed_rows * 2,

    addition(score, Id_player, Final_score),

    score(Id_player, Score),
                   
    write(Stream,' #### Puntuacion final: '), write(Stream,Score), write(Stream,'\n\n')
. 


completed_a_row(_, 0, 0) :- !.

completed_a_row(Wall, Row, Amount) :-

    Next_row is Row - 1,
    
    completed_a_row(Wall, Next_row, New_amount),

    go_as_far_as_you_can(Wall, Next_row, 0, right, 5),
    
    Amount is New_amount + 1, ! 
. 

completed_a_row(Wall, Row, Amount) :-

    Next_row is Row - 1,
    
    completed_a_row(Wall, Next_row, New_amount),

    not(go_as_far_as_you_can(Wall, Next_row, 0, right, 5)),
    
    Amount = New_amount 
. 


completed_a_col(_, 0, 0) :- !.

completed_a_col(Wall, Col, Amount) :-

    Next_col is Col - 1,
    
    completed_a_col(Wall, Next_col, New_amount),

    go_as_far_as_you_can(Wall, 0, Next_col, down, 5),
    
    Amount is New_amount + 1, ! 
. 

completed_a_col(Wall, Col, Amount) :-

    Next_col is Col - 1,
    
    completed_a_col(Wall, Next_col, New_amount),

    not(go_as_far_as_you_can(Wall, 0, Next_col, down, 5)),
    
    Amount = New_amount 
. 


completed_a_tile(_, 0, 0) :- !.

completed_a_tile(Wall, Col, Amount) :-
    
    Next_col is Col - 1,
    
    completed_a_tile(Wall, Next_col, New_amount),
    
    Amount1_in_line is 5 - Next_col, 
    
    go_as_far_as_you_can(Wall, 0, Next_col, diagonal, Amount1_in_line),
    
    go_as_far_as_you_can(Wall, Amount1_in_line, 0, diagonal, Next_col),
    
    Amount is New_amount + 1, ! 
. 

completed_a_tile(Wall, Col, Amount) :-
    
    Next_col is Col - 1,
    
    completed_a_tile(Wall, Next_col, New_amount),
    
    Amount1_in_line is 5 - Next_col,
    
    not(go_as_far_as_you_can(Wall, 0, Next_col, diagonal, Amount1_in_line)),
    
    Amount = New_amount, !
.

completed_a_tile(Wall, Col, Amount) :-

    Next_col is Col - 1,
    
    completed_a_tile(Wall, Next_col, New_amount),

    Amount1_in_line is 5 - Next_col,
    
    not(go_as_far_as_you_can(Wall, Amount1_in_line, 0, diagonal, Next_col)),

    Amount = New_amount
. 
