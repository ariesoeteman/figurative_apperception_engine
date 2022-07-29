
time_overlap((s2v(c_speed, obj_cart_a, 0),1), (s2(c_push, obj_agent, obj_cart_a),1)).

r_before((s2v(c_speed, obj_cart_a, 0),1), (s2(c_push, obj_agent, obj_cart_a),1)).

r_after((s2v(c_speed, obj_cart_a, 0),1), (s2(c_push, obj_agent, obj_cart_a),1)).
r_after((s2(c_push, obj_agent, obj_cart_a),1), (s2v(c_speed, obj_cart_a, 0),1)).

time_overlap((s2v(c_speed, obj_cart_a, 5),1), (s2(c_push, obj_agent, obj_cart_a),1)).

r_before((s2v(c_speed, obj_cart_a, 5),1), (s2(c_push, obj_agent, obj_cart_a),1)).
r_before((s2(c_push, obj_agent, obj_cart_a),1), (s2v(c_speed, obj_cart_a, 5),1)).


r_before((s2(c_push, obj_agent, obj_cart_a) ,1), (s2(c_release, obj_agent, obj_cart_a),1)).
r_before((s2v(c_speed, obj_cart_a,5),1), (s2(c_release, obj_agent, obj_cart_a),1)).

r_after((s2(c_release, obj_agent, obj_cart_a),1), (s2(c_push, obj_agent, obj_cart_a) ,1)).

time_overlap((s2v(c_speed, obj_cart_a, 0),2), (s2(c_release, obj_agent, obj_cart_a),1)).
time_covers((s2(c_release, obj_agent, obj_cart_a),1), (s2v(c_speed, obj_cart_a, 0),2)).

r_before((s2(c_release, obj_agent, obj_cart_a),1), (s2v(c_speed, obj_cart_a, 0),2)).
r_before((s2v(c_speed, obj_cart_a, 5),1), (s2v(c_speed, obj_cart_a, 0),2)).
r_before((s2v(c_speed, obj_cart_a, 0),1), (s2v(c_speed, obj_cart_a, 0),2)).
r_after((s2v(c_speed, obj_cart_a, 0),2),(s2(c_release, obj_agent, obj_cart_a),1)).
r_after((s2v(c_speed, obj_cart_a, 0),2),(s2v(c_speed, obj_cart_a, 5),1)).
r_after((s2v(c_speed, obj_cart_a, 0),2),(s2v(c_speed, obj_cart_a, 0),1)).


time_covers((s2(c_release, obj_agent, obj_cart_b),1), (s2v(c_speed, obj_cart_a,5),1)).
time_covers((s2(c_release, obj_agent, obj_cart_b),1), (s2v(c_speed, obj_cart_a,0),1)).


time_covers((s2(c_release, obj_agent, obj_cart_b),1), (s2(c_release, obj_agent, obj_cart_a),1)).
time_covers((s2(c_release, obj_agent, obj_cart_b),1), (s2v(c_speed, obj_cart_a, 0),2)).

incompossible(c_push, c_release).

is_object(obj_agent).
is_object(obj_cart_a).
is_object(obj_cart_b).


inits(4).
concept_events(12).