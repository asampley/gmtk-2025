extends PanelContainer

func _ready() -> void:
	EventBus.requested_reset_data_popup.connect(on_requested_reset_data_popup)
	hide()

func on_requested_reset_data_popup() -> void:
	show()

func _on_yes_pressed() -> void:
	EventBus.requested_save_data_reset.emit()

func _on_no_pressed() -> void:
	hide()
