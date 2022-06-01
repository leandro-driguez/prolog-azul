
:- ['tiles/tiles_management',
    'pattern_lines/pattern_lines_management',
    'floor_lines/floor_lines_management',
    'initialization/game_initialization',
    'collections/collections_management',
    'game_over/game_over_management',
    'factories/factories_management',
    'players/players_management',
    'scores/scores_management',
    'cover_walls/cover_walls',
    'utils/utils_management',
    'walls/walls_management',
    'maintance/maintance',
    'rounds/execute']
. 

% Relation between number of factories and players
number_of_factories_per_players(5, 2).
number_of_factories_per_players(7, 3).
number_of_factories_per_players(9, 4).


% [greedy,greedy],

new_game(Players) :-

    open('docs/game.txt',write,Stream),

    generate_players(Players),
    
    number_of_players(N),
    
    game_initialization(N),
    
    random(0, N, First_to_play),
    
    write(Stream,'      INICIO DEL JUEGO\n\n'),
    
    factories(Factories),

    write(Stream,'Factories = '), write(Stream,Factories), write(Stream,'\n\n'),
    
    new_game(N, First_to_play, Stream)
. 


new_game(Amount_of_players, First_to_play, Stream) :-
    
    write(Stream,'-------- FASE I: Ejecucion de la ronda --------\n\n'),

    execute_turn(First_to_play, Next_first_to_play, Stream),

    write(Stream,'-------- FASE II: Revestimiento del muro --------\n\n'),

    cover_walls(Amount_of_players, Stream),

    maintance(Stream),

    new_game(Amount_of_players, Next_first_to_play, Stream), !
. 

new_game(Amount_of_players, _, Stream) :-

    game_over_condition,
    
    write(Stream,'-------- GAME OVER --------\n\n'),

    write(Stream,'******** FINAL SCORE ********\n\n'),

    update_final_game_score(Amount_of_players, Stream),

    clean_Db,

    nl(Stream), close(Stream)
. 
