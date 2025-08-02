class_name Objective


var title: String
var reward: int
var number_of_tasks: int = 1
var unlocked_by: ObjectiveTemplate
var tasks_completed: int = 0
var completed: bool = false
var claimed: bool = false
var upgrade_unlock: String


func initialize(template: ObjectiveTemplate) -> void:
	title = template.title
	reward = template.reward
	number_of_tasks = template.number_of_tasks
	if template.upgrade_unlock != null:
		upgrade_unlock = template.upgrade_unlock.upgrade_name
	else:
		upgrade_unlock = ""

func load_save_data(save_data: String) -> void:
	var data_split := save_data.split(",")
	title = data_split[0]
	reward = data_split[1] as int
	number_of_tasks = data_split[2] as int
	tasks_completed = data_split[3] as int
	completed = data_split[4] as int
	claimed = data_split[5] as int
	upgrade_unlock = data_split[6]

func save() -> String:
	var save_string: String = ""
	save_string += title
	save_string += ","
	save_string += str(reward)
	save_string += ","
	save_string += str(number_of_tasks)
	save_string += ","
	save_string += str(tasks_completed)
	save_string += ","
	var completed_int: int = completed
	save_string += str(completed_int)
	save_string += ","
	var claimed_int: int = claimed
	save_string += str(claimed_int)
	save_string += ","
	save_string += str(upgrade_unlock)
	return save_string

func task_completed() -> void:
	tasks_completed += 1
	if tasks_completed >= number_of_tasks:
		completed = true

	if upgrade_unlock != "":
		EventBus.upgrade_unlocked.emit(upgrade_unlock);

func claim() -> void:
	claimed = true
