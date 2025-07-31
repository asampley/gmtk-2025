class_name Objective

var template: ObjectiveTemplate
var tasks_completed: int = 0
var completed: bool
var claimed: bool


func initialize(template_in: ObjectiveTemplate) -> void:
	template = template_in

func task_completed() -> void:
	tasks_completed += 1
	if tasks_completed >= template.number_of_tasks:
		completed = true

func claim() -> void:
	claimed = true
