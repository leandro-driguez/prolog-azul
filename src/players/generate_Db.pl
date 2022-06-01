
:- ['../collections/collections_management', player_Db, random_player/play].


generate_players(Players) :-

    generate_players(Players, 0)
. 


generate_players([random|[]], Id_player) :-

    Number_of_players is Id_player + 1,
   
    assert(number_of_players(Number_of_players)),

    asserta(player(Id_player,random_player_movement)), !
. 

generate_players([greedy|[]], Id_player) :-

    Number_of_players is Id_player + 1,
   
    assert(number_of_players(Number_of_players)),

    asserta(player(Id_player,greedy_player_movement)), !
. 

generate_players([random|Rest_of_the_players], Id_player) :-

    Id_next_player is Id_player + 1,
   
    generate_players(Rest_of_the_players, Id_next_player),

    asserta(player(Id_player, random_player_movement)), !
. 

generate_players([greedy|Rest_of_the_players], Id_player) :-

    Id_next_player is Id_player + 1,
   
    generate_players(Rest_of_the_players, Id_next_player),

    asserta(player(Id_player, greedy_player_movement))
.
