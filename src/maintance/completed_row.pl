
:- ['../scores/scores_management',
    '../walls/wall_Db'
].


someone_completed_a_row(Amount_players) :-

    Id_player is Amount_players - 1,
    
    Id_player >= 0,

    wall(Id_player, Wall),
    
    not(completed_a_row(Wall)),

    someone_completed_a_row(Id_player), !
. 

someone_completed_a_row(Amount_players) :-

    Id_player is Amount_players - 1,

    wall(Id_player, Wall),
    
    completed_a_row(Wall), !
. 


completed_a_row(Wall) :-

    go_as_far_as_you_can(Wall, 0, 0, right, 5), ! 
. 

completed_a_row(Wall) :-

    go_as_far_as_you_can(Wall, 1, 0, right, 5), !
. 

completed_a_row(Wall) :-

    go_as_far_as_you_can(Wall, 2, 0, right, 5), ! 
. 

completed_a_row(Wall) :-

    go_as_far_as_you_can(Wall, 3, 0, right, 5), ! 
. 

completed_a_row(Wall) :-

    go_as_far_as_you_can(Wall, 4, 0, right, 5), ! 
. 

