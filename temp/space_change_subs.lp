% Auto-generated from GenInterpretation

%-----------
% var_types
%-----------

var_type(var_s1, t_cell).
var_type(var_s2, t_sensor).


%--------------
% contains_var
%--------------

contains_var(var_group_s1_s2, var_s1).
contains_var(var_group_s1_s2, var_s2).

contains_var(var_group_s1, var_s1).

contains_var(var_group_s2, var_s2).



%----------
% subs
%----------

subs_group(var_group_s1_s2, subs_s1_s2_1).
subs(subs_s1_s2_1, var_s1, obj_cell_1).
subs(subs_s1_s2_1, var_s2, obj_temp_sensor).

subs_group(var_group_s1_s2, subs_s1_s2_2).
subs(subs_s1_s2_2, var_s1, obj_cell_2).
subs(subs_s1_s2_2, var_s2, obj_temp_sensor).

subs_group(var_group_s1_s2, subs_s1_s2_3).
subs(subs_s1_s2_3, var_s1, obj_cell_3).
subs(subs_s1_s2_3, var_s2, obj_temp_sensor).


subs_group(var_group_s1, subs_s1_1).
subs(subs_s1_1, var_s1, obj_cell_1).

subs_group(var_group_s1, subs_s1_2).
subs(subs_s1_2, var_s1, obj_cell_2).

subs_group(var_group_s1, subs_s1_3).
subs(subs_s1_3, var_s1, obj_cell_3).


subs_group(var_group_s2, subs_s2_1).
subs(subs_s2_1, var_s2, obj_temp_sensor).


