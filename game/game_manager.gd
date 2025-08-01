extends Node2D

@export var rollercoaster_template: RollercoasterTemplate
@export var rollercoaster_parent: Node2D

var current_rollercoaster_stats: RollercoasterStats
var upgrade_dict: Dictionary[UpgradeTemplate, bool] = {} # bool is if the upgrade has been purchased


func _ready() -> void:
	connect_events()
	generate_upgrade_dict()
	spawn_rollercoaster()

func connect_events() -> void:
	EventBus.upgrade_purchased.connect(on_upgrade_purchased)
	EventBus.station_stop.connect(on_station_stop)
	EventBus.station_exit.connect(on_station_exit)

func spawn_rollercoaster() -> void:
	var rollercoaster: CharacterBody2D = rollercoaster_template.prefab.instantiate()
	rollercoaster_parent.add_child(rollercoaster)
	if current_rollercoaster_stats == null:
		current_rollercoaster_stats = RollercoasterStats.new()
		current_rollercoaster_stats.initialize(rollercoaster_template)
	rollercoaster.set_stats(current_rollercoaster_stats)
	var initial_impulse_direction := Vector2.RIGHT
	rollercoaster.velocity += initial_impulse_direction * rollercoaster.stats.initial_velocity

func generate_upgrade_dict() -> void:
	for upgrade_template: UpgradeTemplate in DataHandler.upgrade_resources:
		upgrade_dict[upgrade_template] = false

func on_upgrade_purchased(upgrade_template: UpgradeTemplate) -> void:
	upgrade_dict[upgrade_template] = true
	current_rollercoaster_stats.apply_upgrade(upgrade_template)
	EventBus.upgrade_menu_opened.emit(upgrade_dict)

func open_menus() -> void:
	EventBus.upgrade_menu_opened.emit(upgrade_dict)
	EventBus.objective_menu_requested.emit()

func on_station_stop() -> void:
	open_menus()
	

func on_station_exit() -> void:
	pass
