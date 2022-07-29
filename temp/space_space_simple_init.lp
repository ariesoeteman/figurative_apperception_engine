% Auto-generated from GenInterpretation

{ init(s2v(c_intensity, obj_cell_1, 0)) } .
{ init(s2v(c_intensity, obj_cell_1, 1)) } .
{ init(s2v(c_intensity, obj_cell_2, 0)) } .
{ init(s2v(c_intensity, obj_cell_2, 1)) } .

:- init(c_intensity, obj_cell_1, X), init(c_intensity, obj_cell_1, Y), X != Y.
:- init(c_intensity, obj_cell_2, X), init(c_intensity, obj_cell_2, Y), X != Y.
