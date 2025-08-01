class_name UpgradeSelector
extends PanelContainer


var upgrade: Upgrade
@onready var icon: TextureRect = %Icon
@onready var cost: Label = %Cost


func initialize(upgrade_in: Upgrade) -> void:
	upgrade = upgrade_in
	icon.texture = upgrade.purchase_icon
	cost.text = str(upgrade.cost)

func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_released("left_click"):
		if Globals.money >= upgrade.cost:
			EventBus.upgrade_purchased.emit(upgrade)
		else:
			print_debug("Not enough money")

func _on_mouse_entered() -> void:
	EventBus.tooltip_requested.emit(upgrade.description, get_global_mouse_position())

func _on_mouse_exited() -> void:
	EventBus.tooltip_hidden.emit()
