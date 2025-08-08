extends Camera2D

@export var logarithmic_zoom_scaling: bool
@export var min_zoom: float
@export var max_zoom: float
@export var max_speed: float
var base_node: CharacterBody2D


func initialize(base_node_in: CharacterBody2D) -> void:
	base_node = base_node_in

func _process(_delta: float) -> void:
	if logarithmic_zoom_scaling:
		logarithmic_scaling()
	else:
		linear_scaling()

func linear_scaling() -> void:
	var current_speed := base_node.velocity.length()
	var zoom_multiplier := current_speed / max_speed
	var zoom_amount: float = clamp(min_zoom / zoom_multiplier, min_zoom, max_zoom)
	zoom = Vector2(zoom_amount, zoom_amount)

func logarithmic_scaling() -> void:
	var current_speed := base_node.velocity.length()
	var zoom_multiplier := current_speed / max_speed
	var logarithmic_zoom_multiplier := log(1.0 + (zoom_multiplier * 9.0)) / log(10.0)
	var zoom_amount: float = clamp(min_zoom / logarithmic_zoom_multiplier, min_zoom, max_zoom)
	zoom = Vector2(zoom_amount, zoom_amount)
