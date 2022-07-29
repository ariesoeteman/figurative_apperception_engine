module FigurativeTemplates where

import Interpretation
    
-------------------------------------- Templates ------------------------------
figurative_templates :: [(String, (String, Template, String))]
figurative_templates = [
    ("simple.lp", ("data/time", template_simple, "simple.lp")),
    ("simple_2.lp", ("data/time", template_simple_2, "simple_2.lp")),
    ("coffee.lp", ("data/time", template_coffee, "coffee.lp")),
    ("speeding.lp", ("data/time", template_speeding, "speeding.lp")),
    ("space_simple.lp", ("data/space", template_space_simple, "space_simple.lp")),
    ("leftright.lp", ("data/space", template_leftright, "leftright.lp")),
    ("change.lp", ("data/space", template_change, "change.lp"))
   ]

frame_simple :: Frame    
frame_simple = Frame {
    types = [T "sensor_1", T "sensor_2"],
    type_hierarchy = [],
    objects = [
        (O "sensor_a", T "sensor_1"),
        (O "sensor_b", T "sensor_2")
        ],
    exogeneous_objects = [],
    permanent_concepts = [],
    fluid_concepts = [
        (C "on", [T "sensor_1"]), 
        (C "off", [T "sensor_1"]),
        (C "a", [T "sensor_2"]), 
        (C "b", [T "sensor_2"]),
        (C "c", [T "sensor_2"]) 
        ],
    input_concepts = [],
    static_concepts = [],
    value_concepts = [],
    vars = [
        (V "s1", T "sensor_1"),
        (V "s2", T "sensor_2")
        ],
    var_groups = [
        [V "s1"],
        [V "s2"]
        ],
    aux_files = []
}

template_simple :: Template
template_simple = Template {
    dir = "time",
    frame = frame_simple,
    num_causal_rules = 5,
    num_regular_successions = 1
    }


frame_simple_2 :: Frame    
frame_simple_2 = Frame {
    types = [T "sensor_1"],
    type_hierarchy = [],
    objects = [
        (O "sensor_a", T "sensor_1")
        ],
    exogeneous_objects = [],
    permanent_concepts = [],
    fluid_concepts = [
        (C "on", [T "sensor_1"]), 
        (C "off", [T "sensor_1"])
        ],
    input_concepts = [],
    static_concepts = [],
    value_concepts = [],
    vars = [
        (V "s1", T "sensor_1")
        ],
    var_groups = [
        [V "s1"]
        ],
    aux_files = []
}

template_simple_2 :: Template
template_simple_2 = Template {
    dir = "time",
    frame = frame_simple_2,
    -- min_body_atoms = 0,
    -- max_body_atoms = 3, 
    num_causal_rules = 0,
    num_regular_successions = 2
    }

frame_coffee :: Frame    
frame_coffee = Frame {
    types = [T "resource", T "machine"],
    type_hierarchy = [],
    objects = [
        (O "water", T "resource"),
        (O "maker", T "machine")
        ],
    exogeneous_objects = [],
    permanent_concepts = [],
    fluid_concepts = [
        (C "on", [T "machine"]), 
        (C "off", [T "machine"]),
        (C "basin", [T "resource"]), 
        (C "vape", [T "resource"]),
        (C "filter", [T "resource"]), 
        (C "coffee", [T "resource"]) 
        ],
    static_concepts = [],
    input_concepts = [C "on", C "off", C "basin", C "vape", C "filter", C "coffee"],
    value_concepts = [
        (C "temp", T "resource", (0, 10)) 
    ],
    vars = [
        (V "x", T "machine"),
        (V "y", T "resource")
        ],
    var_groups = [
        [V "x", V "y"],
        [V "x"],
        [V "y"]
        ],
    aux_files = []
}

template_coffee :: Template
template_coffee = Template {
    dir = "time",
    frame = frame_coffee,
    num_causal_rules = 5,
    num_regular_successions = 1
    }



frame_speeding :: Frame    
frame_speeding = Frame {
    types = [T "agent", T "cart"],
    type_hierarchy = [],
    objects = [
        (O "person", T "agent"),
        (O "cart_a", T "cart"),
        (O "cart_b", T "cart")
        ],
    exogeneous_objects = [],
    permanent_concepts = [],
    fluid_concepts = [
        (C "push", [T "agent", T "cart"]), 
        (C "release", [T "agent", T "cart"])
        ],
    value_concepts = [
        (C "speed", T "cart", (0, 10))
        ],
    input_concepts = [C "push", C "release", C "speed"],
    static_concepts = [],
    vars = [
        (V "x", T "agent"),
        (V "y", T "cart")
        ],
    var_groups = [
        [V "x", V "y"],
        [V "x"],
        [V "y"]
        ],
    aux_files = []
}

template_speeding :: Template
template_speeding = Template {
    dir = "time",
    frame = frame_speeding,
    num_causal_rules = 2,
    num_regular_successions = 2
    }

frame_space_simple :: Frame    
frame_space_simple = Frame {
    types = [T "cell"],
    type_hierarchy = [],
    objects = [
        (O "cell_1", T "cell"),
        (O "cell_2", T "cell")
        ],
    exogeneous_objects = [],
    permanent_concepts = [],
    fluid_concepts = [],
    value_concepts = [
        (C "intensity", T "cell", (0, 1)) 
    ],
    input_concepts = [],
    static_concepts = [],
    vars = [
        (V "x", T "cell")
        ],
    var_groups = [
        [V "x"]
        ],
    aux_files = []
}

template_space_simple :: Template
template_space_simple = Template {
    dir = "space",
    frame = frame_space_simple,
    num_causal_rules = 0,
    num_regular_successions = 2
    }


frame_leftright :: Frame    
frame_leftright = Frame {
    types = [T "cell"],
    type_hierarchy = [],
    objects = [
        (O "cell_1", T "cell"),
        (O "cell_2", T "cell")
        ],
    exogeneous_objects = [],
    permanent_concepts = [],
    fluid_concepts = [],
    value_concepts = [
        (C "intensity", T "cell", (0, 1)) 
    ],
    input_concepts = [],
    static_concepts = [],
    vars = [
        (V "x", T "cell")
        ],
    var_groups = [
        [V "x"]
        ],
    aux_files = []
}

template_leftright :: Template
template_leftright = Template {
    dir = "space",
    frame = frame_space_simple,
    num_causal_rules = 0,
    num_regular_successions = 0
    }

frame_change :: Frame    
frame_change = Frame {
    types = [T "cell", T "sensor"],
    type_hierarchy = [],
    objects = [
        (O "cell_1", T "cell"),
        (O "cell_2", T "cell"),
        (O "cell_3", T "cell"),
        (O "temp_sensor", T "sensor")
        ],
    exogeneous_objects = [],
    permanent_concepts = [],
    fluid_concepts = [],
    value_concepts = [
        (C "intensity", T "cell", (0, 1)),
        (C "temp", T "sensor", (0,10)) 
    ],
    input_concepts = [],
    static_concepts = [],
    vars = [
        (V "s1", T "cell"),
        (V "s2", T "sensor")
        ],
    var_groups = [
        [V "s1", V "s2"],
        [V "s1"],
        [V "s2"]
        ],
    aux_files = []
}

template_change :: Template
template_change = Template {
    dir = "space",
    frame = frame_change,
    num_causal_rules = 1,
    num_regular_successions = 0
    }

