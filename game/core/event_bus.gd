extends Node

signal debug_collision_position(position: Vector2)

#Upgrade Purchasing
signal upgrade_menu_opened(upgrade_dict: Dictionary[UpgradeTemplate, bool])
signal upgrade_purchased(upgrade_template: UpgradeTemplate)
signal tooltip_requested(description: String, spawn_position: Vector2)
signal tooltip_hidden()

#Objectives
signal objective_menu_requested()
signal bookmarked_objective_changed()
signal objective_task_completed(objective_title: String)

#doing tricks
signal combo_completed(combo_name: String)
