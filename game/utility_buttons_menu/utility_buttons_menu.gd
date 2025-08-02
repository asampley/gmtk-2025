extends HBoxContainer


func _on_reset_save_pressed() -> void:
	EventBus.requested_reset_data_popup.emit()

func _on_mute_music_toggled(toggled_on: bool) -> void:
	var busIndex: int = AudioServer.get_bus_index("music")
	AudioServer.set_bus_mute(busIndex, toggled_on)

func _on_mute_sfx_toggled(toggled_on: bool) -> void:
	var busIndex: int = AudioServer.get_bus_index("sfx")
	AudioServer.set_bus_mute(busIndex, toggled_on)
