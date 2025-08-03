extends Node


const OBJECTIVES_SAVE_FOLDER: String = "user://objectives/"

@export var default_objective: ObjectiveTemplate

func _ready() -> void:
	if check_save_file_exists():
		load_data_from_save()
	else:
		load_data_from_resources()
	EventBus.station_stop.connect(save_data)
	EventBus.shop_menu_closed.connect(save_data)
	EventBus.requested_save_data_reset.connect(on_requested_save_data_reset)
	EventBus.objective_task_completed.connect(on_objective_task_completed)
	EventBus.objective_completed.connect(on_objective_completed)

func load_data_from_resources() -> void:
	for template: ObjectiveTemplate in DataHandler.objective_resources:
		var objective := Objective.new()
		objective.initialize(template)
		Globals.objectives[objective.template.title] = objective
	Globals.bookmarked_objective = Globals.objectives[default_objective.title]
	EventBus.bookmarked_objective_changed.emit()

func load_data_from_save() -> void:
	var objectives_save_dir := DirAccess.open(OBJECTIVES_SAVE_FOLDER)
	for resource_file: String in objectives_save_dir.get_files():
		var loaded_file := FileAccess.open(OBJECTIVES_SAVE_FOLDER + resource_file, FileAccess.READ)
		var save_data: String = loaded_file.get_as_text()
		var objective := Objective.new()
		objective.load_save_data(save_data)
		Globals.objectives[objective.template.title] = objective
	print(SaveData.data_dictionary)
	var bookmarked_objective_title: String = SaveData.data_dictionary["bookmarked_objective_title"]
	Globals.bookmarked_objective = Globals.objectives[bookmarked_objective_title]
	EventBus.bookmarked_objective_changed.emit()

func on_objective_task_completed(objective_title: String) -> void:
	if Globals.objectives.has(objective_title):
		Globals.objectives[objective_title].task_completed()
	else:
		printerr("There is a mistitled objective task.")

func on_objective_completed() -> void:
	for objective: Objective in Globals.objectives.values():
		if !objective.completed:
			Globals.bookmarked_objective = objective
			EventBus.bookmarked_objective_changed.emit()

func check_save_file_exists() -> bool:
	var dir := DirAccess.open(OBJECTIVES_SAVE_FOLDER)
	return dir != null

func save_data() -> void:
	SaveData.save("bookmarked_objective_title", Globals.bookmarked_objective.template.title)
	if !DirAccess.dir_exists_absolute(OBJECTIVES_SAVE_FOLDER):
		DirAccess.make_dir_recursive_absolute(OBJECTIVES_SAVE_FOLDER)
	for objective: Objective in Globals.objectives.values():
		var save_data := objective.save()
		var file := FileAccess.open(OBJECTIVES_SAVE_FOLDER + objective.template.title + ".dat", FileAccess.WRITE)
		file.store_string(save_data)
		file.close()

func on_requested_save_data_reset() -> void:
	var dir := DirAccess.open(OBJECTIVES_SAVE_FOLDER)
	if dir != null:
		for file: String in dir.get_files():
			DirAccess.remove_absolute(OBJECTIVES_SAVE_FOLDER + file)
		DirAccess.remove_absolute(OBJECTIVES_SAVE_FOLDER)
