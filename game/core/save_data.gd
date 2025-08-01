extends Node

const SAVE_PATH = "user://save_game.dat"
var data_dictionary: Dictionary[String, String] = {}

func _ready() -> void:
	if check_save_file_exists():
		load_save()

func save(data_key: String, data_value: String) -> void:
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(data_key + "," + data_value + ";")
	file.close()

func load_save() -> void:
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	var save_data_array: PackedStringArray = file.get_as_text().split(";")
	for data: String in save_data_array:
		var key_pair := data.split(",")
		data_dictionary[save_data_array[0]] = save_data_array[1]

func check_save_file_exists() -> bool:
	return FileAccess.file_exists(SAVE_PATH)
