extends PanelContainer


@export var objective_item_prefab: PackedScene
@export var color_rect: ColorRect
@export var number_of_stripes: int = 24


@onready var title: Label = %Title
@onready var tasks_completed: Label = %TasksCompleted
@onready var completed_icon: TextureRect = %CompletedIcon


func _ready() -> void:
	EventBus.bookmarked_objective_changed.connect(on_bookmarked_objective_changed)
	EventBus.bookmarked_objective_updated.connect(on_bookmarked_objective_changed)

func on_bookmarked_objective_changed() -> void:
	var objective := Globals.bookmarked_objective
	title.text = objective.template.title
	if objective.tasks_completed >= objective.template.number_of_tasks:
		tasks_completed.hide()
		completed_icon.show()
	else:
		tasks_completed.text = str(objective.tasks_completed) + " / " + str(objective.template.number_of_tasks)
		tasks_completed.show()
		completed_icon.hide()
