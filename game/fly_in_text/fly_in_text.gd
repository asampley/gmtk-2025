extends Label


var duration: float = 2
@export var fade_time: float = 0.5
var fading := false


func initialize(text_in: String) -> void:
	text = text_in
	await get_tree().create_timer(duration).timeout
	fading = true

func _process(delta: float) -> void:
	if !fading:
		return
	modulate.a -= 1 / fade_time * delta
	if modulate.a <= 0:
		queue_free()
