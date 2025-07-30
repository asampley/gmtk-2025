extends State


@export var stopped_state: State
var last_position: Vector2

func enter() -> void:
	super()
	base_node.set_colour(Color.WHITE)

func exit() -> void:
	super()

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	var base_node_as_rigidbody := base_node as RigidBody2D
	if base_node.linear_velocity.length() <= 10:
		return stopped_state
	return null

func process_physics(delta: float) -> State:
	return null
