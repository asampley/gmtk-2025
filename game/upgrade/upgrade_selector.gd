class_name UpgradeSelector
extends PanelContainer

var template: UpgradeTemplate

func initialize(template_in: UpgradeTemplate) -> void:
	template = template_in


func _on_gui_input(event: InputEvent) -> void:
	EventBus.upgrade_purchased.emit(template)

func _on_mouse_entered() -> void:
	EventBus.tooltip_requested.emit(template.description, get_global_mouse_position())

func _on_mouse_exited() -> void:
	EventBus.tooltip_hidden.emit()
