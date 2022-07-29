senses(s(c_on, obj_sensor_a), 1).
senses(s(c_off, obj_sensor_a), 2).
senses(s(c_on, obj_sensor_a), 3).
senses(s(c_off, obj_sensor_a), 4).

inits(2).
concept_events(8).

incompossible(s(c_on, obj_sensor_a), s(c_off,obj_sensor_a)).
