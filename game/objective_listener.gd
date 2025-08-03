extends Node

func _ready() -> void:
	EventBus.combo_completed.connect(on_combo_completed)

func on_combo_completed(combo_name: String, _current_score: float, _current_mult: float) -> void:
	match combo_name:
		"Front Flip":
			EventBus.objective_task_completed.emit("Do a Front Flip")
		"Barrel Roll":
			EventBus.objective_task_completed.emit("Do a Barrel Roll")
		
