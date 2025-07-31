class_name Tooltip
extends PanelContainer


@onready var description: Label = %Description
var viewport_bounds_padding := 4


func _ready() -> void:
	EventBus.tooltip_requested.connect(on_tooltip_requested)
	EventBus.tooltip_hidden.connect(on_tooltip_hidden)

func clamp_to_screen(mouse_position: Vector2) -> void:
	var screen_size := get_viewport_rect().size
	var inbounds_pos := Vector2.ZERO
	inbounds_pos.x = clamp(mouse_position.x, 0, screen_size.x - size.x - viewport_bounds_padding)
	inbounds_pos.y = clamp(mouse_position.y, 0 , screen_size.y - size.y - viewport_bounds_padding)
	set_position(inbounds_pos)

func on_tooltip_requested(description_text: String, mouse_position: Vector2) -> void:
	description.text = description_text
	clamp_to_screen(mouse_position)
	show()

func on_tooltip_hidden() -> void:
	hide()
