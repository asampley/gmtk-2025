extends Camera2D

@export var speed = 4000
var inputDirection: Vector2

func _process(delta: float) -> void:
	inputDirection = Input.get_vector("move_left","move_right","move_up","move_down")

func _physics_process(delta: float) -> void:
	position += inputDirection * speed * delta

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		EventBus.screen_shake_increased.emit(5)
