

space_senses(sv(c_intensity,0), 1,1).

senses(s2v(c_temp, obj_temp_sensor, 0), 2).

move(right, (1,2)).


space_senses(sv(c_intensity,0), 2,1).


move(left, (2,3)).

space_senses(sv(c_intensity,1), 3, 1).


move(right, (3,4)).

space_senses(sv(c_intensity,2), 4, 1).



space_senses(sv(c_intensity,3), 5, 1).


inits(3).
concept_events(5).
is_object(cell1; cell2; cell3).
is_object(obj_temp_sensor).