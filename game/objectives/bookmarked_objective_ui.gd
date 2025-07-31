extends PanelContainer


@export var objective_item_prefab: PackedScene
@onready var objective_item_parent: MarginContainer = %ObjectiveItemParent


func _ready() -> void:
	EventBus.bookmarked_objective_changed.connect(on_bookmarked_objective_changed)

func on_bookmarked_objective_changed() -> void:
	for child: Node in objective_item_parent.get_children():
		child.queue_free()
	for objective: Objective in Globals.objectives.values():
		var objective_item := objective_item_prefab.instantiate()
		objective_item_parent.add_child(objective_item)
		objective_item.initialize(objective)
