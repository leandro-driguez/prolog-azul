
:- ['../tiles/tiles_management',
    '../pattern_lines/pattern_lines_management',
    '../floor_lines/floor_lines_management',
    '../factories/factories_management',
    '../scores/scores_management',
    '../walls/walls_management']
.


game_initialization(Amount_of_players) :-
    
    generate_tiles_Db,
    generate_factory_Db,
    generate_factories(bag),
    generate_scores(Amount_of_players),
    generate_walls(Amount_of_players),
    generate_pattern_lines(Amount_of_players),
    generate_floor_lines(Amount_of_players)
. 
