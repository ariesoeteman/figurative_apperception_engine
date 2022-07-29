% Auto-generated from GenInterpretation

%------------------------------------------------------------------------------
% Elements
%------------------------------------------------------------------------------

is_concept(c_on).
is_concept(c_off).
is_concept(c_a).
is_concept(c_b).
is_concept(c_c).
is_type(t_sensor_1).
is_type(t_sensor_2).

%------------------------------------------------------------------------------
% Typing
%------------------------------------------------------------------------------

permanent(isa(t_sensor_1, obj_sensor_a)).
permanent(isa(t_sensor_2, obj_sensor_b)).


%------------------------------------------------------------------------------
% Update rules
%------------------------------------------------------------------------------

1 { rule_var_group(R, VG) : is_var_group(VG) } 1 :- is_fig_rule(R), use_rule(R).

1 { rule_body(R, VA) : var_content(VA) } 1 :- is_fig_rule(R), use_rule(R).

1 { rule_head_co(R, CO) : head_content(CO) } 1 :- is_fig_rule(R), use_rule(R).

is_regsucc_rule(r1).
is_causal_rule(r2).
is_causal_rule(r3).
is_causal_rule(r4).
is_causal_rule(r5).
is_causal_rule(r6).
{ use_rule(R) } :- is_regsucc_rule(R).
{ use_rule(R) } :- is_causal_rule(R).

%------------------------------------------------------------------------------
% Stats
%------------------------------------------------------------------------------

num_objects(2).
num_variables(2).
