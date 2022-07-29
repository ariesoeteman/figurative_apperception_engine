%%%% HOUSE 1

space_senses(sv(c_intensity, 0), 1,1).
space_senses(sv(c_intensity, 1), 1,1).
space_senses(sv(c_intensity, 1), 1,2).
space_senses(sv(c_intensity, 0), 1,2).

space_senses(sv(c_intensity, 1), 2,1).
space_senses(sv(c_intensity, 1), 2,2).
space_senses(sv(c_intensity, 0), 2,1).
space_senses(sv(c_intensity, 0), 2,2).


move(east, (1,2)).


incompossible(sv(c_intensity,1), sv(c_intensity,0)).

is_object(cell1; cell2; cell3; cell4; cell5; cell6; cell7; cell8).

