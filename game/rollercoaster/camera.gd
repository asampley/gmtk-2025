extends Camera2D


@export var min_zoom: float
@export var max_zoom: float
@export var max_speed: float
@export var speed_divider: float
var base_node: CharacterBody2D


func initialize(base_node_in: CharacterBody2D) -> void:
	base_node = base_node_in

func _process(delta: float) -> void:
	var current_speed := base_node.velocity.length() / speed_divider
	var zoom_multiplier := log(max_speed / current_speed)
	var zoom_diff := max_zoom - min_zoom
	var zoom_amount: float = clamp(zoom_diff * zoom_multiplier, min_zoom, max_zoom)
	zoom = Vector2(zoom_amount, zoom_amount)
	print(zoom_multiplier)
