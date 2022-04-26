space_senses(sv(c_intensity, 0), 1,1).
space_senses(sv(c_intensity, 0), 1,2).

move(right, (1,2)).

space_senses(sv(c_intensity,0), 2, 1).
space_senses(sv(c_intensity,1), 2, 1).

move(right, (2,3)).

space_senses(sv(c_intensity,1), 3, 1).
space_senses(sv(c_intensity,1), 3, 1).

move(right, (3,4)).

space_senses(sv(c_intensity,1), 4, 1).
space_senses(sv(c_intensity,0), 4, 1).


move(left, (4,5)).

space_senses(sv(c_intensity,1), 5, 1).
space_senses(sv(c_intensity,1), 5, 2).

move(left, (5,6)).

space_senses(sv(c_intensity,1), 6, 1).
space_senses(sv(c_intensity,0), 6, 1).

incompossible(sv(c_intensity,1), sv(c_intensity,0)).
inits(3).
concept_events(0).
is_object(cell1; cell2 ; cell3).


#show pos_init_event/1.
#show init/1.

