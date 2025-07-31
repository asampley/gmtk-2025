extends State


@export var moving_on_rails_state: State
@export var falling_state: State


func enter() -> void:
	super()
	base_node.set_colour(Color.GREEN)
	base_node.velocity.y += -base_node.stats.jump_force

func exit() -> void:
	super()

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	var base_node_as_characterbody := base_node as CharacterBody2D
	base_node_as_characterbody.velocity.y += gravity * delta
	if base_node_as_characterbody.velocity.y > 0:
		return falling_state
	base_node_as_characterbody.move_and_slide()
	return null
