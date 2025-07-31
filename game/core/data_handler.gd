extends Node


var combo_resource_group: ResourceGroup = preload("res://game/template/combo_resource_group.tres")

var combo_resources: Array[Resource] = []

func _ready() -> void:
	combo_resource_group.load_all_into(combo_resources)
	print(combo_resources)
