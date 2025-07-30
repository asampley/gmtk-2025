extends State


@export var moving_state: State
var last_position: Vector2


func enter() -> void:
	super()
	base_node.set_colour(Color.RED)

func exit() -> void:
	super()

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	var base_node_as_rigidbody := base_node as RigidBody2D
	print(base_node.velocity)
	#var speed := base_node.velocity
	return null

func process_physics(delta: float) -> State:
	return null
