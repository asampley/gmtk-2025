extends Node


func _ready() -> void:
	load_objectives()

func load_objectives() -> void:
	for template: ObjectiveTemplate in DataHandler.objective_resources:
		var objective := Objective.new()
		objective.initialize(template)
		Globals.objectives[template.title] = objective
	Globals.bookmarked_objective = Globals.objectives["Finished White Line"]
	EventBus.bookmarked_objective_changed.emit()

func on_objective_task_completed(objective_title: String) -> void:
	if Globals.objectives.has(objective_title):
		Globals.objectives[objective_title].task_completed()
	else:
		printerr("There is a mistitled objective task.")
