extends State


@export var moving_state: State
var entered_stopped_state: float


func enter() -> void:
	super()
	base_node.set_colour(Color.RED)
	entered_stopped_state = Time.get_ticks_msec()

func exit() -> void:
	super()

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	var base_node_as_rigidbody := base_node as RigidBody2D
	if base_node.linear_velocity.length() > 10:
		return moving_state
	var time_stopped_in_seconds := (Time.get_ticks_msec()  - entered_stopped_state) / 1000
	if time_stopped_in_seconds > Globals.STOPPED_TIME_UNTIL_CONSIDERED_STUCK:
		print_debug("Stuck")
	return null

func process_physics(delta: float) -> State:
	return null
