extends State


@export var jumping_state: State
@export var falling_state: State
@export var stopped_state: State

var last_position: Vector2

func enter() -> void:
	super()
	base_node.set_colour(Color.WHITE)

func exit() -> void:
	super()

func process_input(event: InputEvent) -> State:
	if event.is_action_pressed("Jump"):
		return jumping_state
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	var base_node_as_characterbody := base_node as CharacterBody2D
	if !base_node_as_characterbody.is_on_floor():
		return falling_state
	if base_node_as_characterbody.velocity.length() <= 10:
		return stopped_state
	base_node_as_characterbody.move_and_slide()
	return null
