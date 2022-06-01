
:- ['../utils/utils', '../collections/collections_management',
    pattern_line_Db]
. 


set_pattern_lines(Id_player, Pattern_lines_index, 
        Tiles, Rest_of_the_tiles
    ) :-
        
    MetaPredicate_Pattern_lines=..[pattern_line, Id_player, 
        Pattern_lines],
    call(MetaPredicate_Pattern_lines),

    index_in_the_list(Pattern_lines, Pattern_lines_index, 
        Pattern_line),

    transducer(MetaPredicate_Pattern_lines, 
        set_pattern_lines_transducer, [Pattern_line, 
        Pattern_lines_index, Tiles, Rest_of_the_tiles])
. 


set_pattern_lines_transducer(MetaPredicate_Pattern_lines, 
        MetaPredicate_Modified_pattern_lines, [[Tile, Top, Top], 
        Pattern_lines_index, Tiles, Rest_of_the_tiles]
    ) :-

    MetaPredicate_Pattern_lines=..[pattern_line,Id_player,
        Pattern_lines],
    
    call(MetaPredicate_Pattern_lines),

    Tiles = [Tile|_],

    length_of_the_list(Tiles, Rest),
    
    generate_list(Rest, Tile, Rest_of_the_tiles),

    New_Top is Pattern_lines_index + 1,

    assign_into_list(Pattern_lines, 
        Modified_pattern_lines, Pattern_lines_index, 
        [Tile, New_Top, New_Top]),
        
    MetaPredicate_Modified_pattern_lines=..[pattern_line,Id_player,
        Modified_pattern_lines], !
. 

set_pattern_lines_transducer(MetaPredicate_Pattern_lines, 
        MetaPredicate_Modified_pattern_lines, 
        [[empty, _, Top], Pattern_lines_index, Tiles, 
        Rest_of_the_tiles]
    ) :-

    MetaPredicate_Pattern_lines=..[pattern_line,Id_player,
        Pattern_lines],
   
    call(MetaPredicate_Pattern_lines),
    
    Tiles = [Tile|_],

    length_of_the_list(Tiles, Amount),
    
    Amount >= Top,

    Rest is Amount - Top,
    
    generate_list(Rest, Tile, Rest_of_the_tiles),
    
    assign_into_list(Pattern_lines, Modified_pattern_lines, 
        Pattern_lines_index, [Tile, Top, Top]),
        
    MetaPredicate_Modified_pattern_lines=..[pattern_line,Id_player,
        Modified_pattern_lines], !
. 

set_pattern_lines_transducer(MetaPredicate_Pattern_lines, 
        MetaPredicate_Modified_pattern_lines, 
        [[empty, _, Top], Pattern_lines_index, Tiles, 
        Rest_of_the_tiles]
    ) :-

    MetaPredicate_Pattern_lines=..[pattern_line,Id_player,
        Pattern_lines],
    
    call(MetaPredicate_Pattern_lines),
        
    Tiles = [Tile|_],
    
    length_of_the_list(Tiles, Amount),
    
    Amount < Top,
    
    assign_into_list(Pattern_lines, Modified_pattern_lines, 
        Pattern_lines_index, [Tile, Amount, Top]), 
    
    Rest_of_the_tiles = [],
        
    MetaPredicate_Modified_pattern_lines=..[pattern_line,Id_player,
        Modified_pattern_lines], !
. 

set_pattern_lines_transducer(MetaPredicate_Pattern_lines, 
        MetaPredicate_Modified_pattern_lines, 
        [Pattern_line, _, Tiles, 
        Rest_of_the_tiles]
    ) :-

    MetaPredicate_Pattern_lines=..[pattern_line,Id_player,
        Pattern_lines],
    
    call(MetaPredicate_Pattern_lines),
        
    Pattern_line = [Tile,_,_],

    Tiles = [First_item|_],

    Tile \= First_item,

    Rest_of_the_tiles = Tiles,
        
    MetaPredicate_Modified_pattern_lines=..[pattern_line,
        Id_player, Pattern_lines], !
. 

set_pattern_lines_transducer(MetaPredicate_Pattern_lines, 
        MetaPredicate_Modified_pattern_lines, 
        [[Tile, Amount, Top], Pattern_lines_index, 
        [_|Rest_of_tiles], Rest]
    ) :-
        
    MetaPredicate_Pattern_lines=..[_,_,_],

    call(MetaPredicate_Pattern_lines),

    New_Top is Top - 1,

    set_pattern_lines_transducer(MetaPredicate_Pattern_lines, 
        MetaPredicate_Modified_pattern_lines, [[Tile, Amount, 
        New_Top], Pattern_lines_index, Rest_of_tiles, Rest])
. 
