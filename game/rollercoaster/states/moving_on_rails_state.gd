extends State


@export var jumping_state: State
@export var falling_state: State
@export var stopped_state: State

var last_position: Vector2
var available_directions: Array[Vector2i] = []

func enter() -> void:
	super()
	base_node.set_colour(Color.WHITE)
	if base_node.get_last_slide_collision() != null:
		var collision := base_node.get_last_slide_collision()
		var collider := collision.get_collider()
		if collider is TileMapLayer:
			var tile_map := collider as Track
			var global_pos := collision.get_position()
			var tile_pos: = tile_map.local_to_map(tile_map.to_local(global_pos))
			var direction := get_direction(base_node.velocity)
			available_directions = tile_map.connections(tile_pos, direction)
			#for direction2 in available_directions:
				#print(direction2)

func exit() -> void:
	super()

func process_input(event: InputEvent) -> State:
	if event.is_action_pressed("Jump"):
		return jumping_state
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	if !base_node.is_on_floor():
		return falling_state
	if base_node.velocity.length() <= 10:
		return stopped_state
	base_node.velocity.y += gravity * delta
	base_node.move_and_slide()
	return null

func get_direction(vector_in: Vector2) -> Vector2i:
	return (Vector2i(-vector_in) / 32).clampi(-1,1)
