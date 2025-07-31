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
		var follow := base_node.path_follow
		var curve := base_node.path.curve

		var near := curve.sample_baked(follow.progress + 0.05)

		print(near - follow.global_position, " . ", curve.get_point_position(1) - follow.global_position, " = ", (near - follow.global_position).dot(curve.get_point_position(1) - follow.global_position))

		# If we are before the branch, update out_direction
		if (follow.global_position - near).dot(follow.global_position - curve.get_point_position(1)) > 0:
			var state := update_path()
			if state != null:
				return state
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	if !base_node.is_on_floor():
		return falling_state

	var curve := base_node.path.curve
	var follow := base_node.path_follow

	# if velocity is against the path, we should update it
	var progress_direction := (curve.sample_baked(follow.progress + 0.05) - (curve.sample_baked(follow.progress - 0.05))).normalized()
	if base_node.velocity.dot(progress_direction) < 0:
		flip()

	var new_progress := follow.progress + base_node.velocity.length() * delta

	if new_progress > curve.get_baked_length():
		new_progress -= curve.get_baked_length()

		print("Leaving tile %s from %s" % [tile_pos, out_direction])
		tile_pos += out_direction
		print("Entering tile %s from %s" % [tile_pos, -out_direction])

		in_direction = -out_direction
		var state := update_path()
		if state != null:
			return state

	var old_pos := base_node.global_position

	base_node.path_follow.progress = new_progress
	base_node.transform = base_node.path_follow.transform

	var direction := (base_node.global_position - old_pos).normalized()

	var dv := (self.gravity * Vector2i.DOWN).project(direction) * delta
	base_node.velocity = base_node.velocity.length() * direction + dv

	# if velocity is against the path, we should update it
	if base_node.velocity.dot(direction) < 0:
		flip()

	if base_node.velocity.length() <= 10 && dv.length_squared() <= 1 * delta:
		return stopped_state

	return null

func flip() -> void:
	var temp := in_direction
	in_direction = out_direction
	out_direction = temp
	base_node.path_follow.progress_ratio = 1 - base_node.path_follow.progress_ratio
	update_path()


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

	var curve := base_node.path.curve

	var available_directions := track.connections(tile_pos, in_direction)

	if available_directions.size() == 0:
		return falling_state

	out_direction = calc_direction(available_directions, Input.is_action_pressed("move_up"), Input.is_action_pressed("move_down"))

	var tile_as_global := track.to_global(track.map_to_local(tile_pos))

	curve.set_point_position(0, tile_as_global + in_direction * track.tile_set.tile_size * 0.5)
	curve.set_point_position(1, tile_as_global)
	curve.set_point_position(2, tile_as_global + out_direction * track.tile_set.tile_size * 0.5)

	return null
