
:- [bag_Db, box_cover_Db, 
    center_of_the_table_Db, 
    tiles_Db]
. 


generate_tiles_Db :-

    assert(bag(red, 20)),
    assert(bag(blue, 20)),
    assert(bag(green, 20)),
    assert(bag(black, 20)),
    assert(bag(yellow, 20)),

    assert(box_cover(red, 0)),
    assert(box_cover(blue, 0)),
    assert(box_cover(green, 0)),
    assert(box_cover(black, 0)),
    assert(box_cover(yellow, 0)),

    assert(center_of_the_table(red, 0)),
    assert(center_of_the_table(blue, 0)),
    assert(center_of_the_table(green, 0)),
    assert(center_of_the_table(black, 0)),
    assert(center_of_the_table(yellow, 0)),

    assert(tiles([black, red, blue, green, yellow]))
. 
