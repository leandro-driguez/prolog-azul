
:- ['../pattern_lines/pattern_lines_management',
    '../tiles/tiles_management',
    '../scores/scores_management',
    '../walls/walls_management'
].

cover_walls(0, _) :- !.

cover_walls(Amount_of_players, Stream) :- 

    Id_player is Amount_of_players - 1,

    cover_walls(Id_player, Stream),

    % se actualiza la puntuacion
    update_player_score(Id_player),

    % limpia la zona de preparacion
    clean_pattern_lines(Id_player, Tiles),

    % actualiza el muro
    set_wall(Id_player, Tiles),

    % limpia la zona final
    floor_line(Id_player, Amount),
    addition(floor_line, Id_player, -Amount),

    % los tiles restantes se colocan en la tapa
    set_box_cover(Tiles),

    write(Stream,'        Jugador '), write(Stream,Id_player),write(Stream,'\n\n'),

    wall(Id_player, Wall),
    
    write(Stream,'Wall = '),write(Stream,Wall),write(Stream,'\n\n'),

    pattern_line(Id_player, Pattern_lines),
    
    write(Stream,'Pattern_lines = '),write(Stream,Pattern_lines),write(Stream,'\n\n'),

    score(Id_player, Score),
    
    write(Stream,'Score = '),write(Stream,Score),write(Stream,'\n\n')
. 


set_box_cover([]) :- !.

set_box_cover([[Tile, Amount]|Rest_of_the_tiles]) :- 

    set_box_cover(Rest_of_the_tiles),

    generate_list(Amount, Tile, Tiles),
 
    add_tiles(box_cover, Tiles)
. 
