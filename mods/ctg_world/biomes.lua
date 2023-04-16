
-- stone
minetest.register_biome({
    name = "caves_stone",
    node_stone = "default:stone",
    y_max = -1000,
    y_min = -10000,
    heat_point = 5,
    humidity_point = 5
})

minetest.register_biome({
    name = "caves_stone2",
    node_stone = "default:stone",
    y_max = -1000,
    y_min = -10000,
    heat_point = 20,
    humidity_point = 8
})

minetest.register_biome({
    name = "caves_stone3",
    node_stone = "default:stone",
    y_max = -1000,
    y_min = -10000,
    heat_point = 50,
    humidity_point = 10
})

-- mossy
minetest.register_biome({
    name = "caves_mossy",
    node_stone = "default:stone",
    y_max = -90,
    y_min = -5000,
    heat_point = 64,
    humidity_point = 40
})

minetest.register_biome({
    name = "caves_mossy2",
    node_stone = "default:stone",
    y_max = -90,
    y_min = -5000,
    heat_point = 67,
    humidity_point = 60
})

minetest.register_biome({
    name = "caves_mossy3",
    node_stone = "default:stone",
    y_max = -100,
    y_min = -5000,
    heat_point = 77,
    humidity_point = 77
})

-- mossy2
minetest.register_biome({
    name = "caves_fungi",
    node_stone = "default:stone",
    y_max = -90,
    y_min = -6000,
    heat_point = 70,
    humidity_point = 93
})

-- drippy
minetest.register_biome({
    name = "caves_drippy",
    node_stone = "default:stone",
    y_max = -100,
    y_min = -11000,
    heat_point = 25,
    humidity_point = 40
})

minetest.register_biome({
    name = "caves_drippy2",
    node_stone = "default:stone",
    y_max = -100,
    y_min = -11000,
    heat_point = 20,
    humidity_point = 60
})

minetest.register_biome({
    name = "caves_drippy3",
    node_stone = "default:stone",
    y_max = -100,
    y_min = -11000,
    heat_point = 28,
    humidity_point = 90
})

-- drippy dry
minetest.register_biome({
    name = "caves_dripped",
    node_stone = "default:stone",
    y_max = -100,
    y_min = -11000,
    heat_point = 67,
    humidity_point = 1
})

minetest.register_biome({
    name = "caves_dripped2",
    node_stone = "default:stone",
    y_max = -100,
    y_min = -11000,
    heat_point = 80,
    humidity_point = 2
})

minetest.register_biome({
    name = "caves_dripped3",
    node_stone = "default:stone",
    y_max = -100,
    y_min = -11000,
    heat_point = 97,
    humidity_point = 3
})

-- bacterial
minetest.register_biome({
    name = "caves_bacterial",
    node_stone = "default:stone",
    y_max = -1000,
    y_min = -11000,
    heat_point = 88,
    humidity_point = 95
})

minetest.register_biome({
    name = "caves_bacterial2",
    node_stone = "default:stone",
    y_max = -1000,
    y_min = -11000,
    heat_point = 90,
    humidity_point = 90
})

minetest.register_biome({
    name = "caves_bacterial3",
    node_stone = "default:stone",
    y_max = -1000,
    y_min = -11000,
    heat_point = 97,
    humidity_point = 100
})