extends State


@export var jumping_state: State
@export var falling_state: State
@export var stopped_state: State

var tile_pos: Vector2i
var in_direction: Vector2i
var out_direction: Vector2i

var track: Track

func enter() -> void:
	super()
	base_node.set_colour(Color.WHITE)
	if base_node.get_last_slide_collision() != null:
		var collision := base_node.get_last_slide_collision()
		var collider := collision.get_collider()
		if collider is Track:
			track = collider as Track
			var global_pos := collision.get_position()
			tile_pos = track.local_to_map(track.to_local(global_pos))
			in_direction = get_direction(base_node.velocity)
			update_path()

func exit() -> void:
	super()

func process_input(event: InputEvent) -> State:
	if event.is_action_pressed("jump"):
		return jumping_state
	if event.is_action_pressed("move_up") || event.is_action_pressed("move_down"):
		var state := update_path()
		if state != null:
			return state
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	if !base_node.is_on_floor():
		return falling_state
	if base_node.velocity.length() <= 10:
		return stopped_state
	#base_node.velocity.y += gravity * delta
	#base_node.move_and_slide()

	var new_progress := base_node.path_follow.progress + base_node.velocity.length() * delta

	if new_progress > base_node.path.curve.get_baked_length():
		new_progress -= base_node.path.curve.get_baked_length()

		print("Leaving tile %s from %s" % [tile_pos, out_direction])
		tile_pos += out_direction
		print("Entering tile %s from %s" % [tile_pos, -out_direction])

		in_direction = -out_direction
		var state:=  update_path()
		if state != null:
			return state
	base_node.path_follow.progress = new_progress
	base_node.transform = base_node.path_follow.transform
	return null

func get_direction(vector_in: Vector2) -> Vector2i:
	return (Vector2i(-vector_in) / 32).clampi(-1,1)

func calc_direction(available_directions: Array[Vector2i], up: bool, down: bool) -> Vector2i:
	if up == down:
		return available_directions[0]
	elif up:
		return available_directions.reduce(func(acc: Vector2i, v: Vector2i) -> Vector2i: return acc if v.y > acc.y else v)
	else:
		return available_directions.reduce(func(acc: Vector2i, v: Vector2i) -> Vector2i: return acc if v.y < acc.y else v)

func update_path() -> State:
	assert(base_node.path.top_level)

	var available_directions := track.connections(tile_pos, in_direction)

	if available_directions.size() == 0:
		return falling_state

	out_direction = calc_direction(available_directions, Input.is_action_pressed("move_up"), Input.is_action_pressed("move_down"))

	var curve := base_node.path.curve
	var tile_as_global := track.to_global(track.map_to_local(tile_pos))

	curve.set_point_position(0, tile_as_global + in_direction * track.tile_set.tile_size * 0.5)
	curve.set_point_position(1, tile_as_global)
	curve.set_point_position(2, tile_as_global + out_direction * track.tile_set.tile_size * 0.5)
	return null
