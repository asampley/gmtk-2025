extends Node

const SAVE_PATH = "user://save_game.dat"
var data_dictionary: Dictionary[String, String] = {}

func _ready() -> void:
	if check_save_file_exists():
		load_save()

func save(data_key: String, data_value: Variant) -> void:
	data_dictionary[data_key] = str(data_value)
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(str(data_dictionary))
	file.close()

func load_save() -> void:
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	var save_data_array: PackedStringArray = file.get_as_text().split(", ")
	for data: String in save_data_array:
		if data != "":
			var regex := RegEx.new()
			regex.compile("[^a-zA-Z0-9:_\\s+]")
			data = regex.sub(data, "", true)
			var key_pair := data.split(": ")
			data_dictionary[key_pair[0].strip_edges()] = key_pair[1].strip_edges()

func reset() -> void:
	DirAccess.remove_absolute(SAVE_PATH)

func check_save_file_exists() -> bool:
	return FileAccess.file_exists(SAVE_PATH)
