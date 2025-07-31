extends PanelContainer


@export var objective_item_prefab: PackedScene
@export var objective_item_parent: Control

func _ready() -> void:
	on_populate_menu()

func on_populate_menu() -> void:
	for child: Node in objective_item_parent.get_children():
		child.queue_free()
	for objective: Objective in Globals.objectives.values():
		var objective_item := objective_item_prefab.instantiate()
		objective_item_parent.add_child(objective_item)
		objective_item.initialize(objective)
