class_name AdvancedButton
extends Button
################################################################################
#
# More features, including playing a sound when clicked
#
################################################################################


@export var sound: AudioStream


func _init() -> void:
	texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR

func _pressed() -> void:
	if sound:
		EventBus.play_ui_sound.emit(sound)
