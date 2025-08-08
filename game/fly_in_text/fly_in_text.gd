extends Label

var new_material: Material = preload("res://game/fly_in_text/fly_in_text_shader_material_prefab.tres")
var new_shader: Shader = preload("res://game/shaders/directional_move.gdshader")
@export var fade_time: float = 0.5

var speed: float
var direction: Vector2
var duration_seconds: float = 2
var fading := false


func initialize(text_in: String, speed_in: float, direction_in: Vector2) -> void:
	EventBus.station_stop.connect(on_stop_entered)
	text = text_in
	speed = speed_in
	direction = direction_in
	await get_tree().create_timer(duration_seconds).timeout
	fading = true

func _process(delta: float) -> void:
	position += direction * speed * delta
	if !fading:
		return
	modulate.a -= 1 / fade_time * delta
	if modulate.a <= 0:
		queue_free()

func on_stop_entered() -> void:
	queue_free()
