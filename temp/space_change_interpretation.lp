% Auto-generated from GenInterpretation

%------------------------------------------------------------------------------
% Elements
%------------------------------------------------------------------------------

is_type(t_cell).
is_type(t_sensor).

%------------------------------------------------------------------------------
% Typing
%------------------------------------------------------------------------------

permanent(isa(t_cell, obj_cell_1)).
permanent(isa(t_cell, obj_cell_2)).
permanent(isa(t_cell, obj_cell_3)).
permanent(isa(t_sensor, obj_temp_sensor)).


%------------------------------------------------------------------------------
% Update rules
%------------------------------------------------------------------------------

1 { rule_var_group(R, VG) : is_var_group(VG) } 1 :- is_fig_rule(R), use_rule(R).

1 { rule_body(R, VA) : var_content(VA) } 1 :- is_fig_rule(R), use_rule(R).

1 { rule_head_co(R, CO) : head_content(CO) } 1 :- is_fig_rule(R), use_rule(R).

is_causal_rule(r1).
{ use_rule(R) } :- is_regsucc_rule(R).
{ use_rule(R) } :- is_causal_rule(R).

%------------------------------------------------------------------------------
% Stats
%------------------------------------------------------------------------------

num_objects(4).
num_variables(2).
