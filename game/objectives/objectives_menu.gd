extends PanelContainer


@export var objective_item_prefab: PackedScene
@export var objective_item_parent: Control

func _ready() -> void:
	on_objective_menu_requested()
	EventBus.objective_menu_requested.connect(on_objective_menu_requested)

func on_objective_menu_requested() -> void:
	for child: Node in objective_item_parent.get_children():
		child.queue_free()
	for objective: Objective in Globals.objectives.values():
		if !objective.claimed:
			var objective_item := objective_item_prefab.instantiate()
			objective_item_parent.add_child(objective_item)
			objective_item.initialize(objective)
	show()
