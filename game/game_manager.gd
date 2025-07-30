extends Node2D

@export var rollercoaster_template: RollercoasterTemplate
@export var rollercoaster_parent: Node2D

var current_rollercoaster_stats: RollercoasterStats

func _ready() -> void:
	spawn_rollercoaster()

func spawn_rollercoaster() -> void:
	var rollercoaster := rollercoaster_template.prefab.instantiate()
	rollercoaster_parent.add_child(rollercoaster)
	if current_rollercoaster_stats == null:
		current_rollercoaster_stats = RollercoasterStats.new()
		current_rollercoaster_stats.initialize(rollercoaster_template)
	rollercoaster.set_stats(current_rollercoaster_stats)
