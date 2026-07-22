local config = {}

-- hitboxes
config.player_mask = 1
config.asteroid_mask = 2
config.wall_mask = 3
config.shot_mask = 4

-- Player
config.player_cooldown = 5
config.player_shape_size = 20
config.player_speed = 30
config.player_rotate_speed = 0.1

-- asteroid
config.asteroid_spawn_frequency = 2
config.asteroid_min_size = 20
config.asteroid_max_size = 30
config.asteroid_min_impulse = 20
config.asteroid_max_impulse = 50

-- shot
config.shot_impulse = 30

-- font
config.gameover_font_size = 40

return config
