class_name Objective

var template_path: String
var template: ObjectiveTemplate

var tasks_completed: int = 0
var completed: bool = false
var claimed: bool = false


func initialize(objective_template: ObjectiveTemplate) -> void:
	template = objective_template
	template_path = objective_template.resource_path

func load_save_data(save_data: String) -> void:
	var data_split := save_data.split(",")
	template_path = data_split[0]
	template = ResourceLoader.load(template_path, "ObjectiveTemplate")
	tasks_completed = data_split[1] as int
	completed = data_split[2] as int
	claimed = data_split[3] as int

func save() -> String:
	var save_string: String = ""
	save_string += template_path
	save_string += ","
	save_string += str(tasks_completed)
	save_string += ","
	var completed_int: int = completed
	save_string += str(completed_int)
	save_string += ","
	var claimed_int: int = claimed
	save_string += str(claimed_int)
	return save_string

func task_completed() -> void:
	tasks_completed += 1
	if tasks_completed >= template.number_of_tasks:
		completed = true

	if template.upgrade_unlock:
		EventBus.upgrade_unlocked.emit(template.upgrade_unlock.upgrade_name);

func claim() -> void:
	claimed = true
