
:- ['../../pattern_lines/pattern_lines_management',
    '../../collections/collections_management']
. 


generate_pattern_lines(Id_player, Tiles, Pattern_lines_index, 
        Pattern_lines_Output, Rest_of_the_tiles
    ) :-

    MetaPredicate_Pattern_lines=..[pattern_line, Id_player, 
        Pattern_lines], 
    call(MetaPredicate_Pattern_lines),

    index_in_the_list(Pattern_lines, Pattern_lines_index, 
        Pattern_line),
        
    set_pattern_lines_transducer(MetaPredicate_Pattern_lines, 
        MetaPredicate_Modified_pattern_lines, 
        [Pattern_line, Pattern_lines_index, Tiles, 
        Rest_of_the_tiles]), 
        
    MetaPredicate_Modified_pattern_lines=..[pattern_line, Id_player,
        Pattern_lines_Output] 
. 

