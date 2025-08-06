class_name SoundTextureButton
extends TextureButton

@export var sound: AudioStream

func _pressed() -> void:
	EventBus.play_ui_sound.emit(sound)
