class_name AdvancedTextureButton
extends TextureButton
################################################################################
#
# More features, including tooltips and playing a sound when clicked
#
################################################################################


@export var sound: AudioStream
@export var game_tooltip_text: String


func _pressed() -> void:
	if sound:
		EventBus.play_ui_sound.emit(sound)
