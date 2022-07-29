% Auto-generated from GenInterpretation

{ init(s(c_on, obj_maker)) } .
{ init(s(c_off, obj_maker)) } .
{ init(s(c_basin, obj_water)) } .
{ init(s(c_vape, obj_water)) } .
{ init(s(c_filter, obj_water)) } .
{ init(s(c_coffee, obj_water)) } .
{ init(s2v(c_temp, obj_water, 0)) } .
{ init(s2v(c_temp, obj_water, 1)) } .
{ init(s2v(c_temp, obj_water, 2)) } .
{ init(s2v(c_temp, obj_water, 3)) } .
{ init(s2v(c_temp, obj_water, 4)) } .
{ init(s2v(c_temp, obj_water, 5)) } .
{ init(s2v(c_temp, obj_water, 6)) } .
{ init(s2v(c_temp, obj_water, 7)) } .
{ init(s2v(c_temp, obj_water, 8)) } .
{ init(s2v(c_temp, obj_water, 9)) } .
{ init(s2v(c_temp, obj_water, 10)) } .

:- init(c_temp, obj_water, X), init(c_temp, obj_water, Y), X != Y.
