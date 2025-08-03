extends PanelContainer


@export var objective_item_prefab: PackedScene
@export var objective_item_parent: Control

func _ready() -> void:
	on_objective_menu_requested()
	EventBus.objective_menu_requested.connect(on_objective_menu_requested)

func on_objective_menu_requested() -> void:
	for child: Node in objective_item_parent.get_children():
		child.queue_free()
	var completed_nodes: Array[Node]
	for objective: Objective in Globals.objectives.values():
		if !objective.claimed:
			var objective_item := objective_item_prefab.instantiate()
			objective_item_parent.add_child(objective_item)
			if objective.completed:
				completed_nodes.append(objective_item)
			objective_item.initialize(objective)
	for node: Node in completed_nodes:
		objective_item_parent.move_child(node, 0)
