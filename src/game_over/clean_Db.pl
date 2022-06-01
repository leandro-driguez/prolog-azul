

clean_Db :- 

    retractall(factories),

    retractall(number_of_factories),

    retractall(floor_line),

    retractall(pattern_line),

    retractall(player),

    retractall(number_of_players),

    retractall(score),

    retractall(bag),

    retractall(box_cover),

    retractall(center_of_the_table),

    retractall(wall), !
. 
