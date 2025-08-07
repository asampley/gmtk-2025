extends Control


@export var text_popup_prefab_1: PackedScene


func _ready() -> void:
	EventBus.popup_text_requested.connect(on_popup_text_requested)

func on_popup_text_requested(text: String, type: int, \
		screen_position: Vector2, duration: float) -> void:
	var text_popup: Control
	match type:
		0:
			text_popup = text_popup_prefab_1.instantiate()
	add_child(text_popup)
	text_popup.position = screen_position
	text_popup.initialize(text, duration)
