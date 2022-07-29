exogenous(s(obj_maker, (c_off, c_on)), (1,2)).

senses(s(c_basin, obj_water),2).


senses(s2v(c_temp, obj_water, 2),2).

senses(s2v(c_temp, obj_water, 6),3).

senses(s2v(c_temp, obj_water, 10),4).

senses(s(c_vape, obj_water),5).


senses(s2v(c_temp, obj_water, 5), 6).


senses(s2v(c_temp, obj_water, 2), 7).


senses(s(c_filter, obj_water),8).

senses(s(c_on, obj_maker), 9).
senses(s(c_coffee, obj_water),9).

senses(s(c_off, obj_maker), 10).


% exogenous(s(obj_water, (c_coffee,c_basin)),(9,10)).

% exogenous(s(obj_maker, (c_off, c_on)), (10,11)).

% senses(s(c_coffee, obj_water), 12).


incompossible(s(c_basin, obj_water), s(c_vape, obj_water)).
incompossible(s(c_basin, obj_water), s(c_filter, obj_water)).
incompossible(s(c_basin, obj_water), s(c_coffee, obj_water)).

incompossible(s(c_vape, obj_water), s(c_filter, obj_water)).
incompossible(s(c_vape, obj_water), s(c_coffee, obj_water)).

incompossible(s(c_filter, obj_water), s(c_coffee, obj_water)).



incompossible(s(c_on, obj_maker), s(c_off, obj_maker)).

inits(3).
concept_events(13).