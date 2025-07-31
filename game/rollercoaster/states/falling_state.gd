extends State


@export var moving_on_rails_state: State
@export var stopped_state: State


func enter() -> void:
	super()
	base_node.set_colour(Color.YELLOW)

func exit() -> void:
	super()

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	var base_node_as_characterbody := base_node as CharacterBody2D
	base_node_as_characterbody.velocity.y += gravity * delta
	base_node_as_characterbody.move_and_slide()
	if base_node_as_characterbody.is_on_floor():
		return moving_on_rails_state
	return null
