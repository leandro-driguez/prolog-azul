
:- ['../utils/utils', '../collections/list'].


remove_factory(Factory_index) :-

    MetaPredicate_Factories=..[factories,_],
   
    call(MetaPredicate_Factories),

    transducer(MetaPredicate_Factories, remove_factory_transducer, 
        [Factory_index]), !
.  

remove_factory_transducer(
        MetaPredicate_Factories, MetaPredicate_Factories_Modificated,
        [Factory_index]
    ):-

    MetaPredicate_Factories=..[factories, List], 
   
    call(MetaPredicate_Factories),

    MetaPredicate_Number_of_Factories=..[number_of_factories, Value],
   
    call(MetaPredicate_Number_of_Factories),

    MetaPredicate_Remove=..[remove_this_item_from_the_list, List, 
        Factory_index, Resulting_list],
   
    call(MetaPredicate_Remove),

    MetaPredicate_Factories_Modificated=..[factories, Resulting_list],
   
    New_value is Value - 1,
   
    New_value was_assigned_to number_of_factories
. 
