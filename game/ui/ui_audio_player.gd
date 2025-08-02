extends AudioStreamPlayer

func _ready() -> void:
	EventBus.play_ui_sound.connect(on_play_ui_sound)

func on_play_ui_sound(sound: AudioStream) -> void:
	stream = sound
	play()
