class_name UpgradeSelector
extends PanelContainer


var template: UpgradeTemplate
@onready var icon: TextureRect = %Icon
@onready var cost: Label = %Cost


func initialize(template_in: UpgradeTemplate) -> void:
	template = template_in
	icon.texture = template.purchase_icon
	cost.text = str(template.cost)

func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_released("left_click"):
		if Globals.MONEY >= template.cost:
			EventBus.upgrade_purchased.emit(template)
		else:
			print_debug("Not enough money")

func _on_mouse_entered() -> void:
	EventBus.tooltip_requested.emit(template.description, get_global_mouse_position())

func _on_mouse_exited() -> void:
	EventBus.tooltip_hidden.emit()
