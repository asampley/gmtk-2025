extends Control

@export var animate_duration_seconds: float

var animate: bool
var animation_time: float

func _ready() -> void:
	EventBus.to_the_moon.connect(start_animation)
	modulate = Color(1, 1, 1, 0)
	hide()

func _process(delta: float) -> void:
	if animate:
		animation_time += delta
		if animation_time > animate_duration_seconds:
			animate = false
			modulate = Color(1, 1, 1, 1)
		elif animation_time > 0:
			modulate = Color(1, 1, 1, animation_time / animate_duration_seconds)

func start_animation() -> void:
	var index := AudioServer.get_bus_index("sfx")
	AudioServer.set_bus_mute(index, true)
	show()
	animate = true
	animation_time = 0


func _on_reset_data_pressed() -> void:
	EventBus.requested_save_data_reset.emit()
	get_tree().reload_current_scene()

func _on_reset_scene_pressed() -> void:
	get_tree().reload_current_scene()
