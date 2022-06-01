
:- ['../factories/factories_management', 
    '../tiles/tiles_management',
    '../players/player_Db', completed_row]
. 


maintance(Stream) :-

    not(game_over_condition),

    write(Stream,'-------- FASE III: Mantenimiento --------\n\n'),

    fill_the_bag,

    generate_factories(bag),

    factories(Factories),

    factories(Factories), 
    
    write(Stream,'Factories = '), write(Stream,Factories), write(Stream,'\n\n')
. 


game_over_condition :-
    
    bag does_not_have _ available,
    
    box_cover does_not_have _ available
. 

game_over_condition :-
    
    number_of_players(Amount_of_players),
    
    someone_completed_a_row(Amount_of_players)
. 


fill_the_bag :-

    get_all_tiles(box_cover, black, Amount_black),
    
    addition(bag, black, Amount_black),

    get_all_tiles(box_cover, red, Amount_red),
    
    addition(bag, red, Amount_red),

    get_all_tiles(box_cover, blue, Amount_blue),
    
    addition(bag, blue, Amount_blue),

    get_all_tiles(box_cover, green, Amount_green),
    
    addition(bag, green, Amount_green),

    get_all_tiles(box_cover, yellow, Amount_yellow),
    
    addition(bag, yellow, Amount_yellow)
. 

