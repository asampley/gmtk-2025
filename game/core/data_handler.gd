extends Node


var combo_resources: Array[Resource] = []
var upgrade_resources: Array[Resource] = []
var objective_resources: Array[Resource] = []

var combo_resource_folder := "res://game/template/combos/"
var upgrade_resource_folder := "res://game/template/upgrades/"
var objective_resource_folder := "res://game/template/objectives/"

var debug_string: String

func _ready() -> void:
	for path: String in get_resource_paths(combo_resource_folder):
		combo_resources.append(ResourceLoader.load(path))
	for path: String in get_resource_paths(upgrade_resource_folder):
		upgrade_resources.append(ResourceLoader.load(path))
		#debug_string += str(upgrade_resources.size()) + " | "
	for path: String in get_resource_paths(objective_resource_folder):
		objective_resources.append(ResourceLoader.load(path))

#func _unhandled_input(event: InputEvent) -> void:
	#EventBus.debug.emit(debug_string)

func get_resource_paths(path: String) -> PackedStringArray:
	var paths: PackedStringArray = []
	for resource_name: String in DirAccess.get_files_at(path):
		if OS.has_feature("web"):
			resource_name = resource_name.trim_suffix(".remap")
		paths.append(path + resource_name)
	return paths
