extends Label

func _ready() -> void:
	EventBus.debug.connect(debug)

func debug(text_in: String) -> void:
	text += text_in
