extends Node2D


@export var rollercoaster_template: RollercoasterTemplate
@export var rollercoaster_parent: Node2D

var current_rollercoaster_stats: RollercoasterStats
var upgrades: Array[Upgrade] = []

const UPGRADES_SAVE_FOLDER: String = "user://upgrades/"


func _ready() -> void:
	connect_events()
	if check_save_file_exists():
		load_data_from_save()
	else:
		load_data_from_resources()
	spawn_rollercoaster()

func connect_events() -> void:
	EventBus.upgrade_purchased.connect(on_upgrade_purchased)
	EventBus.station_stop.connect(on_station_stop)
	EventBus.shop_menu_closed.connect(on_shop_menu_closed)
	EventBus.requested_save_data_reset.connect(on_requested_save_data_reset)

func spawn_rollercoaster() -> void:
	var rollercoaster: CharacterBody2D = rollercoaster_template.prefab.instantiate()
	rollercoaster_parent.add_child(rollercoaster)
	if current_rollercoaster_stats == null:
		current_rollercoaster_stats = RollercoasterStats.new()
		current_rollercoaster_stats.initialize(rollercoaster_template)
	rollercoaster.set_stats(current_rollercoaster_stats)
	var initial_impulse_direction := Vector2.RIGHT
	rollercoaster.velocity += initial_impulse_direction * rollercoaster.stats.initial_velocity

func on_upgrade_purchased(upgrade: Upgrade) -> void:
	upgrade.purchase_upgrade()
	current_rollercoaster_stats.apply_upgrade(upgrade)
	EventBus.upgrade_menu_opened.emit(upgrades)

func open_menus() -> void:
	EventBus.upgrade_menu_opened.emit(upgrades)

func on_station_stop() -> void:
	open_menus()
	save_data()

func on_shop_menu_closed() -> void:
	save_data()
	spawn_rollercoaster()

func load_data_from_resources() -> void:
	Globals.money = 0
	for upgrade_template: UpgradeTemplate in DataHandler.upgrade_resources:
		var upgrade := Upgrade.new()
		upgrade.initialize(upgrade_template)
		upgrades.append(upgrade)

func load_data_from_save() -> void:
	Globals.money = int(SaveData.data_dictionary["money"])
	var upgrades_save_dir := DirAccess.open(UPGRADES_SAVE_FOLDER)
	for resource_file: String in upgrades_save_dir.get_files():
		var loaded_file := FileAccess.open(UPGRADES_SAVE_FOLDER + resource_file, FileAccess.READ)
		var save_data: String = loaded_file.get_as_text()
		var upgrade := Upgrade.new()
		upgrade.load_save_data(save_data)
		upgrades.append(upgrade)

func save_data() -> void:
	SaveData.save("money", Globals.money)
	DirAccess.make_dir_recursive_absolute(UPGRADES_SAVE_FOLDER)
	for upgrade: Upgrade in upgrades:
		var save_data := upgrade.save()
		var file := FileAccess.open(UPGRADES_SAVE_FOLDER + upgrade.upgrade_name + ".dat", FileAccess.WRITE)
		file.store_string(save_data)
		file.close()

func check_save_file_exists() -> bool:
	var dir := DirAccess.open(UPGRADES_SAVE_FOLDER)
	return dir != null

func on_requested_save_data_reset() -> void:
	SaveData.reset()
	if DirAccess.open(UPGRADES_SAVE_FOLDER) == null:
		return
	var dir := DirAccess.open(UPGRADES_SAVE_FOLDER)
	for file: String in dir.get_files():
		DirAccess.remove_absolute(UPGRADES_SAVE_FOLDER + file)
	DirAccess.remove_absolute(UPGRADES_SAVE_FOLDER)
