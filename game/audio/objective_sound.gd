extends AudioStreamPlayer

@export var objective_sound : AudioStream

func _ready() -> void:
	EventBus.objective_completed.connect(on_objective_task_completed)
	stream = objective_sound

func on_objective_task_completed() -> void:
	play()
