class_name Upgrade

var template_path: String
var template: UpgradeTemplate

var purchased: int
var unlocked: bool


func initialize(upgrade_template: UpgradeTemplate) -> void:
	template = upgrade_template
	template_path = template.resource_path
	unlocked = template.unlocked

func load_save_data(save_data: String) -> void:
	var data_split := save_data.split(",")
	template_path = data_split[0]
	template = ResourceLoader.load(template_path, "UpgradeTemplate")
	purchased = data_split[1] as int
	unlocked = data_split[2] as int

func save() -> String:
	var save_string: String = ""
	save_string += str(template_path)
	save_string += ","
	save_string += str(purchased)
	save_string += ","
	var unlocked_int: int = unlocked
	save_string += str(unlocked_int)
	return save_string

func purchase_upgrade() -> void:
	if purchased == 0:
		for upgrade in template.unlocks:
			EventBus.upgrade_unlocked.emit(upgrade.upgrade_name)

	purchased += 1

func available() -> bool:
	return unlocked && purchased < template.tiers.size()

func next_tier() -> UpgradeTierTemplate:
	return template.tiers[purchased]
