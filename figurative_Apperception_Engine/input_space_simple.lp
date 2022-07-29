space_senses(sv(c_intensity, 1), 1,1).
space_senses(sv(c_intensity, 1), 1,2).
space_senses(sv(c_intensity, 1), 1,3).
space_senses(sv(c_intensity, 1), 1,4).
space_senses(sv(c_intensity, 1), 1,5).
space_senses(sv(c_intensity, 1), 1,6).
space_senses(sv(c_intensity, 1), 1,7).
space_senses(sv(c_intensity, 1), 1,8).
space_senses(sv(c_intensity, 1), 1,9).
space_senses(sv(c_intensity, 1), 1,10).
space_senses(sv(c_intensity, 1), 1,11).
space_senses(sv(c_intensity, 1), 1,12).
space_senses(sv(c_intensity, 1), 1,13).
space_senses(sv(c_intensity, 1), 1,14).
space_senses(sv(c_intensity, 1), 1,15).
space_senses(sv(c_intensity, 1), 1,16).

space_senses(sv(c_intensity, 1), 1,17).
space_senses(sv(c_intensity, 1), 1,18).
space_senses(sv(c_intensity, 1), 1,19).
space_senses(sv(c_intensity, 1), 1,20).
space_senses(sv(c_intensity, 1), 1,21).
space_senses(sv(c_intensity, 1), 1,22).
space_senses(sv(c_intensity, 1), 1,23).
space_senses(sv(c_intensity, 1), 1,24).
space_senses(sv(c_intensity, 1), 1,25).


inits(1).
concept_events(1).

is_object(cell1; cell2).

{init(s2v(c_intensity, cell1, 1))}.
{init(s2v(c_intensity, cell2, 1))}.
{init(s2v(c_intensity, cell1, 0))}.
{init(s2v(c_intensity, cell2, 0))}.

incompossible(sv(c_intensity,1), sv(c_intensity,0)).