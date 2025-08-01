extends State

@export var falling_state: State

var station: Station

var track: Track

func enter() -> void:
	super()
	assert(station)
	EventBus.station_stop.emit()
	base_node.velocity = Vector2.ZERO
	update_path()

func exit() -> void:
	super()
	station = null
	EventBus.station_exit.emit()

func process_input(event: InputEvent) -> State:
	if event.is_action_pressed("move_up"):
		base_node.velocity = base_node.stats.initial_velocity * (station.out_direction as Vector2).normalized()
		return falling_state

	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	var follow := base_node.path_follow

	if follow.progress_ratio < 1:
		follow.progress_ratio += (1 - follow.progress_ratio) * 0.05 + 0.05 * delta
		base_node.transform = base_node.path_follow.transform

	return null

# estimate_progress assigns the progress as well, based on the current location
func update_path() -> State:
	assert(base_node.path.top_level)

	var curve := base_node.path.curve

	curve.clear_points()
	curve.add_point(global_position)
	curve.add_point(station.stop_tile * 64 + Vector2i.ONE * 32)

	base_node.path_follow.progress = 0

	return null
