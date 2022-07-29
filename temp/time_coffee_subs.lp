% Auto-generated from GenInterpretation

%-----------
% var_types
%-----------

var_type(var_x, t_machine).
var_type(var_y, t_resource).


%--------------
% contains_var
%--------------

contains_var(var_group_x_y, var_x).
contains_var(var_group_x_y, var_y).

contains_var(var_group_x, var_x).

contains_var(var_group_y, var_y).



%----------
% subs
%----------

subs_group(var_group_x_y, subs_x_y_1).
subs(subs_x_y_1, var_x, obj_maker).
subs(subs_x_y_1, var_y, obj_water).


subs_group(var_group_x, subs_x_1).
subs(subs_x_1, var_x, obj_maker).


subs_group(var_group_y, subs_y_1).
subs(subs_y_1, var_y, obj_water).


