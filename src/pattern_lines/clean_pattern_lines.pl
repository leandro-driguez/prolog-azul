
:- ['../collections/collections_management',
    '../utils/utils_management',
    pattern_line_Db
].


clean_pattern_lines([], [], []) :- !.

clean_pattern_lines([[Tile, Top, Top]|Rest_of_the_pattern_lines], 
        Modified_pattern_lines, Resulting_list
    ) :-

    clean_pattern_lines(Rest_of_the_pattern_lines, 
        Modified_rest_of_the_pattern_lines, Resulting_rest),
        
    Modified_pattern_lines = [[empty, 0, Top] | 
        Modified_rest_of_the_pattern_lines],
    
    Index is Top - 1,

    Tiles = [Tile, Index],

    Resulting_list = [Tiles | Resulting_rest], !
. 

clean_pattern_lines([Pattern_lines|Rest_of_the_pattern_lines], 
        Modified_pattern_lines, Resulting_list
    ) :-

    clean_pattern_lines(Rest_of_the_pattern_lines, 
        Modified_rest_of_the_pattern_lines, Resulting_list),
        
    Modified_pattern_lines = [Pattern_lines | 
        Modified_rest_of_the_pattern_lines], !
.


clean_pattern_lines_transducer(MetaPredicate_Pattern_lines,
        MetaPredicate_Modified_pattern_lines, [Resulting_list]
    ) :-

    MetaPredicate_Pattern_lines=..[pattern_line, Id_player, 
        Pattern_lines],
    call(MetaPredicate_Pattern_lines),

    clean_pattern_lines(Pattern_lines, Modified_pattern_lines, 
        Resulting_list),

    MetaPredicate_Modified_pattern_lines=..[pattern_line, Id_player, 
        Modified_pattern_lines]
. 


clean_pattern_lines(Id_player, Resulting_list) :-

    MetaPredicate=..[pattern_line, Id_player,_],
    call(MetaPredicate),

    transducer(MetaPredicate, clean_pattern_lines_transducer, 
        [Resulting_list])
.  

