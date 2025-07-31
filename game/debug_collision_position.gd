extends Sprite2D

@export var tile_map: TileMapLayer

func _ready() -> void:
	EventBus.debug_collision_position.connect(on_debug_collision_position)

func on_debug_collision_position(col_pos: Vector2) -> void:
	position = col_pos

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("LeftClick"):
		var local_pos := tile_map.get_local_mouse_position()
		var map_pos := tile_map.local_to_map(local_pos)
		print(map_pos)
