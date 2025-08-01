extends Node

const SAVE_PATH = "user://save_game.dat"
var data_dictionary: Dictionary[String, String] = {}

func _ready() -> void:
	if check_save_file_exists():
		load_save()

func save(data_key: String, data_value: Variant) -> void:
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(data_key + "," + str(data_value) + ";")
	file.close()

func load_save() -> void:
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	var save_data_array: PackedStringArray = file.get_as_text().split(";")
	for data: String in save_data_array:
		if data != "":
			var key_pair := data.split(",")
			data_dictionary[key_pair[0]] = key_pair[1]

func reset() -> void:
	DirAccess.remove_absolute(SAVE_PATH)

func check_save_file_exists() -> bool:
	return FileAccess.file_exists(SAVE_PATH)
