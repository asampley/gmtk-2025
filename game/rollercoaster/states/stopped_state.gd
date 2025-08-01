extends State


@export var moving_on_rails_state: State
@export var falling_state: State
@export var stopped_state: State

var entered_stopped_state: float


func enter() -> void:
	super()
	entered_stopped_state = Time.get_ticks_msec()

func exit() -> void:
	super()

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	if base_node.velocity.length() > 10:
		return moving_on_rails_state
	var time_stopped_in_seconds := (Time.get_ticks_msec()  - entered_stopped_state) / 1000
	if time_stopped_in_seconds > Globals.stopped_time_until_considered_stuck:
		print_debug("Stuck")
	return null
