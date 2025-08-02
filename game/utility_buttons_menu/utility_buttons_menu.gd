extends HBoxContainer


func _on_reset_save_pressed() -> void:
	EventBus.requested_save_data_reset.emit()

func _on_mute_music_pressed() -> void:
	pass # Replace with function body.

func _on_mute_sfx_pressed() -> void:
	pass # Replace with function body.
