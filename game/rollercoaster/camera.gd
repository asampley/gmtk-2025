extends Camera2D


@export var min_zoom: float
@export var max_zoom: float
@export var max_speed: float
var base_node: CharacterBody2D


func initialize(base_node_in: CharacterBody2D) -> void:
	base_node = base_node_in

func _process(delta: float) -> void:
	var current_speed := base_node.velocity.length()
	var zoom_multiplier := current_speed / max_speed
	var zoom_amount: float = clamp(min_zoom / zoom_multiplier, min_zoom, max_zoom)
	zoom = Vector2(zoom_amount, zoom_amount)
