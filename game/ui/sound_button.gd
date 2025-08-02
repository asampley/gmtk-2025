class_name SoundButton
extends Button

@export var sound: AudioStream

func _pressed() -> void:
	EventBus.play_ui_sound.emit(sound)
