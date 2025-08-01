extends Button


func _on_pressed() -> void:
	EventBus.requested_save_data_reset.emit()
