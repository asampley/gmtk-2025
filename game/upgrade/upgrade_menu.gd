extends PanelContainer

@export var upgrade_selector_prefab: PackedScene
@onready var upgrade_selector_parent: GridContainer = %UpgradeSelectorParent


func _ready() -> void:
	EventBus.upgrade_menu_opened.connect(on_upgrade_menu_opened)

func on_upgrade_menu_opened(upgrade_dict: Dictionary[UpgradeTemplate, bool]) -> void:
	for child: Node in upgrade_selector_parent.get_children():
		child.queue_free()
	for upgrade_template in upgrade_dict:
		if upgrade_dict[upgrade_template] == false:
			var upgrade_selector: UpgradeSelector = upgrade_selector_prefab.instantiate()
			upgrade_selector_parent.add_child(upgrade_selector)
			upgrade_selector.initialize(upgrade_template)
	show()
