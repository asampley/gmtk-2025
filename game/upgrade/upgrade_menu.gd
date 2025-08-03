extends PanelContainer

@export var upgrade_selector_prefab: PackedScene
@onready var upgrade_selector_parent: GridContainer = %UpgradeSelectorParent
@onready var money_text: Label = %MoneyText


func _ready() -> void:
	EventBus.upgrade_menu_opened.connect(on_upgrade_menu_opened)
	EventBus.money_amount_changed.connect(on_money_amount_changed)

func on_upgrade_menu_opened(upgrades: Array[Upgrade]) -> void:
	for child: Node in upgrade_selector_parent.get_children():
		child.queue_free()
	for upgrade in upgrades:
		if upgrade.available() && upgrade.unlocked:
			var upgrade_selector: UpgradeSelector = upgrade_selector_prefab.instantiate()
			upgrade_selector_parent.add_child(upgrade_selector)
			upgrade_selector.initialize(upgrade)

func _on_finished_pressed() -> void:
	EventBus.shop_menu_closed.emit()

func on_money_amount_changed(money: int) -> void:
	money_text.text = "Money: $%s" % money
