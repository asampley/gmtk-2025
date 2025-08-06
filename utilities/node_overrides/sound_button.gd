class_name SoundButton
extends Button

@export var sound: AudioStream


func _init() -> void:
	texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR


func _pressed() -> void:
	EventBus.play_ui_sound.emit(sound)
