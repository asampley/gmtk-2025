extends Node


var objectives: Dictionary[String, Objective] ={}


func _ready() -> void:
	load_objectives()

func load_objectives() -> void:
	for template: ObjectiveTemplate in DataHandler.objective_resources:
		var objective := Objective.new()
		objective.initialize(template)
		objectives[template.title] = objective

func on_objective_task_completed(objective_title: String) -> void:
	if objectives.has(objective_title):
		objectives[objective_title].task_completed()
	else:
		printerr("There is a mistitled objective task.")
