extends Label

var display_timer: = 0
var display_duration: = 1.5

func _ready() -> void:
	visible = false
	EventBus.combo_completed.connect(display_text)

func _process(delta: float) -> void:
	if display_timer > 0:
		display_timer -= delta

	if display_timer <= 0:
			visible = false

func display_text(combo_name: String) -> void:
	visible = true
	text = "Sweet %s !" % combo_name
	display_timer = display_duration
