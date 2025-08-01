class_name Upgrade


var upgrade_name: String
var purchased: bool = false
var add_initial_velocity: float
var add_jump_force: float


func initialize(template: UpgradeTemplate) -> void:
	upgrade_name = template.upgrade_name
	add_initial_velocity = template.add_initial_velocity
	add_jump_force = template.add_jump_force

func load_save_data(save_data: String) -> void:
	var data_split := save_data.split(",")
	upgrade_name = data_split[0]
	purchased = data_split[1] as bool
	add_initial_velocity = data_split[2] as float
	add_jump_force = data_split[3] as float

func save() -> String:
	var save_string: String = ""
	save_string += upgrade_name
	save_string += ","
	save_string += str(purchased)
	save_string += ","
	save_string += str(add_initial_velocity)
	save_string += ","
	save_string += str(add_jump_force)
	save_string += ";"
	return save_string

func purchase_upgrade() -> void:
	purchased = true
