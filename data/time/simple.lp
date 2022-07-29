senses(s(c_off, obj_sensor_a), 2).
senses(s(c_a, obj_sensor_b), 2).
senses(s(c_on, obj_sensor_a), 3).
senses(s(c_a, obj_sensor_b), 3).
senses(s(c_off, obj_sensor_a), 4).
senses(s(c_off, obj_sensor_a), 6).
senses(s(c_a, obj_sensor_b), 6).

senses(s(c_off, obj_sensor_a), 7).


incompossible(s(c_on, X), s(c_off, X)) :-
    permanent(isa(t_sensor_1, X)).


incompossible(s(c_a, X), s(c_b, X)) :-
    permanent(isa(t_sensor_2, X)).

incompossible(s(c_a, X), s(c_c, X)) :-
    permanent(isa(t_sensor_2, X)).

incompossible(s(c_b, X), s(c_c, X)) :-
    permanent(isa(t_sensor_2, X)).

inits(2).
concept_events(16).