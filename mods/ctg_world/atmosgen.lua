minetest.register_biome({
    name = "deep_space",
    node_stone = "vacuum:vacuum",
    y_max = 31000,
    y_min = 22000,
    heat_point = 0,
    humidity_point = 0
})

minetest.register_biome({
    name = "red_space",
    node_stone = "vacuum:vacuum",
    y_max = 22000,
    y_min = 16000,
    heat_point = 20,
    humidity_point = 0
})

minetest.register_biome({
    name = "mid_space",
    node_stone = "vacuum:vacuum",
    y_max = 16000,
    y_min = 10000,
    heat_point = 0,
    humidity_point = 0
})

minetest.register_biome({
    name = "space",
    node_stone = "vacuum:vacuum",
    node_top = "vacuum:vacuum",
    node_filler = "vacuum:vacuum",
    y_max = 10000,
    y_min = 4000,
    heat_point = 0,
    humidity_point = 0
})

minetest.register_biome({
    name = "upper_atmos",
    node_stone = "vacuum:atmos_thin",
    y_max = 4000,
    y_min = 2000,
    heat_point = 10,
    humidity_point = 5
})

minetest.register_biome({
    name = "lower_atmos",
    node_stone = "air",
    y_max = 2001,
    y_min = 1000,
    heat_point = 20,
    humidity_point = 20
})
