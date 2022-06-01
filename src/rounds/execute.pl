
:- ['../factories/factories_management', 
    '../pattern_lines/pattern_lines_management',
    '../collections/collections_management',
    '../floor_lines/floor_lines_management',
    '../tiles/tiles_management',
    '../utils/utils_management',
    '../players/play']
. 


execute_turn(_, _, _) :-

    factories(Factories),
    
    Factories = [],
    
    center_of_the_table does_not_have _ available, !
. 

execute_turn(Id_player, First_to_play, Stream) :-
    
    % si hay fabricas con capacidad     
    factories(Factories),

    Factories \= [],
    
    % escoja una jugada
    play(Id_player, Factory_index, Tile, Pattern_lines_index),
    
    % si la jugada la selecciono de una fabrica
    Factory_index \= -1,
    
    index_in_the_list(Factories, Factory_index, Factory),
        
    % tome todos los tiles del mismo color de la fabrica
    
    get_all_items_of_the_list(Factory, Tile, 
        Tiles, Rest_of_the_tiles),

    % annadalos a la zona de preparacion
    
    set_pattern_lines(Id_player, Pattern_lines_index, 
        Tiles, For_the_floor_line),

    % los restantes annadalos al centro de mesa
    % write(Stream,'fabrica: '), write(Stream,' los restantes annadalos al centro de mesa '), write(Stream,Id_player), write(Stream,'\n'),
    add_tiles(center_of_the_table, Rest_of_the_tiles),

    % los que sobraron para la zona de preparacion annadalos 
    % a la zona final
    add_to_floor_line(Id_player, For_the_floor_line, Leftover_tiles),
    
    % los tiles que sobraron de insertar en la zona final se 
    % annaden a la tapa
    add_tiles(box_cover, Leftover_tiles),

    % elimina la fabrica escogida
    remove_factory(Factory_index),
    
    % que juegue el proximo jugador
    number_of_players(Number_of_players),
    
    Id_next_player is (Id_player + 1) mod Number_of_players,

    Number_of_player is Id_player + 1,

    write(Stream,'            Jugador '), write(Stream,Number_of_player), write(Stream,'\n\n'),
    
    write(Stream,' ---> Selecciona los tiles '), write(Stream,Tile), 
    
    write(Stream,' de la fabrica '), write(Stream,Factory),
    
    write(Stream,' y los coloca en la fila '), write(Stream,Pattern_lines_index),
    
    write(Stream,' de la zona de preparacion.\n\n'),

    write(Stream,'      Tablero Personal \n\n'),

    pattern_line(Id_player, Pattern_lines),
    
    write(Stream,'Pattern_lines = '),write(Stream,Pattern_lines),write(Stream,'\n\n'),

    floor_line(Id_player, Floor_line),
    
    write(Stream,'Floor_line = '),write(Stream,Floor_line),write(Stream,'\n\n'),

    write(Stream,'****** Estado de las fabricas y centro de mesa al finalizar el turno ****** \n\n'),
    
    factories(Modified_factories), 

    write(Stream,'Factories = '), write(Stream,Modified_factories), write(Stream,'\n\n'),
    
    center_of_the_table(black, Amount_black),

    write(Stream,'Center of the table = '), write(Stream,'black: '), write(Stream,Amount_black), write(Stream,'\n'),
    
    center_of_the_table(red, Amount_red),

    write(Stream,'                      '), write(Stream,'red: '), write(Stream,Amount_red), write(Stream,'\n'), 

    center_of_the_table(blue, Amount_blue),

    write(Stream,'                      '), write(Stream,'blue: '), write(Stream,Amount_blue), write(Stream,'\n'), 

    center_of_the_table(green, Amount_green),

    write(Stream,'                      '), write(Stream,'green: '), write(Stream,Amount_green), write(Stream,'\n'), 

    center_of_the_table(yellow, Amount_yellow),

    write(Stream,'                      '), write(Stream,'yellow: '), write(Stream,Amount_yellow), write(Stream,'\n\n'), 

    execute_turn(Id_next_player, First_to_play, Stream), !
. 

execute_turn(Id_player, First_to_play, Stream) :-
    
    play(Id_player, Factory_index, Tile, Pattern_lines_index),
    
    Factory_index = -1, 

    write(Stream,'centro: '), write(Stream,' si la jugada la selecciono del centro '), write(Stream,Id_player), write(Stream,'\n'),
    
    get_all_tiles(center_of_the_table, Tile, Amount),

    generate_list(Amount, Tile, Tiles),

    % annadalos a la zona de preparacion
    set_pattern_lines(Id_player,Pattern_lines_index,Tiles,For_the_floor_line),
    
    % los que sobraron para la zona de preparacion annadalos 
    % a la zona final
    add_to_floor_line(Id_player, For_the_floor_line, Leftover_tiles),
    
    % los tiles que sobraron de insertar en la zona final se 
    % annaden a la tapa
    add_tiles(box_cover, Leftover_tiles),
    
    % que juegue el proximo jugador
    number_of_players(Number_of_players),

    Id_next_player is (Id_player + 1) mod Number_of_players,

    first_to_play(Id_player, First_to_play),

    Number_of_player is Id_player + 1,

    write(Stream,'            Jugador '), write(Stream,Number_of_player), write(Stream,'\n\n'),
    
    write(Stream,' ---> Selecciona los tiles '), write(Stream,Tile), 
    
    write(Stream,' del centro de la mesa y los coloca en la fila '), write(Stream,Pattern_lines_index),
    
    write(Stream,' de la zona de preparacion.\n\n'),

    write(Stream,'      Tablero Personal \n\n'),

    pattern_line(Id_player, Pattern_lines),
    
    write(Stream,'Pattern_lines = '),write(Stream,Pattern_lines),write(Stream,'\n\n'),

    floor_line(Id_player, Floor_line),
    
    write(Stream,'Floor_line = '),write(Stream,Floor_line),write(Stream,'\n\n'),

    write(Stream,'****** Estado de las fabricas y centro de mesa al finalizar el turno ****** \n\n'),
    
    factories(Factories), 
    
    write(Stream,'Factories = '), write(Stream,Factories), write(Stream,'\n\n'),
    
    center_of_the_table(black, Amount_black),
    
    write(Stream,'Center of the table = '), write(Stream,'black: '), write(Stream,Amount_black), write(Stream,'\n'),
    
    center_of_the_table(red, Amount_red),
    
    write(Stream,'                      '), write(Stream,'red: '), write(Stream,Amount_red), write(Stream,'\n'), 

    center_of_the_table(blue, Amount_blue),
    
    write(Stream,'                      '), write(Stream,'blue: '), write(Stream,Amount_blue), write(Stream,'\n'), 

    center_of_the_table(green, Amount_green),
    
    write(Stream,'                      '), write(Stream,'green: '), write(Stream,Amount_green), write(Stream,'\n'), 

    center_of_the_table(yellow, Amount_yellow),
    
    write(Stream,'                      '), write(Stream,'yellow: '), write(Stream,Amount_yellow), write(Stream,'\n\n'), 

    execute_turn(Id_next_player, First_to_play, Stream), !
. 

execute_turn(Id_player, First_to_play, Stream) :- execute_turn(Id_player, First_to_play, Stream). 



first_to_play(_, First_to_play) :-
 
    nonvar(First_to_play), !
. 

first_to_play(Id_player, First_to_play) :-
 
    var(First_to_play), 
    
    First_to_play = Id_player
. 
    

add_to_floor_line(Id_player, Tiles, Leftover_tiles) :-

    length_of_the_list(Tiles, Amount),

    floor_line(Id_player, Current_amount),
    
    New_amount is 7 - Current_amount, 
    
    New_amount < Amount,

    addition(floor_line, Id_player, New_amount),

    Amount_of_leftover_tiles is Amount - New_amount,

    Tiles = [Tile|_],
    
    generate_list(Amount_of_leftover_tiles, Tile, Leftover_tiles), !
. 

add_to_floor_line(Id_player, Tiles, Leftover_tiles) :-

    length_of_the_list(Tiles, Amount),

    floor_line(Id_player, Current_amount),
    
    New_amount is 7 - Current_amount, 
    
    New_amount >= Amount,

    addition(floor_line, Id_player, Amount),
    
    Leftover_tiles = [], !
. 
