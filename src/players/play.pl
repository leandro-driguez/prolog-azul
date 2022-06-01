
:- [random_player/play, player_Db].


play(Id_player, Factory_index, Tiles, Pattern_line_index) :-
 
    player(Id_player, Strategy),
    
    MetaStrategy=..[Strategy, Id_player, Factory_index, Tiles, Pattern_line_index],
    
    call(MetaStrategy)
. 
