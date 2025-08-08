extends Control


@onready var text: Label = %Text
var screen_position: Vector2


func initialize(text_in: String, screen_position_in: Vector2, duration_seconds: float) -> void:
	text.text = text_in
	screen_position = screen_position_in
	await get_tree().create_timer(duration_seconds).timeout
	queue_free()

func _on_text_resized() -> void:
	position.x = screen_position.x - (get_rect().size.x / 2)
	position.y = screen_position.y - get_rect().size.y
