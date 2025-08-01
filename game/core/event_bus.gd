extends Node

signal debug_collision_position(position: Vector2)
signal requested_save_data_reset()

#Upgrade Purchasing
signal upgrade_menu_opened(upgrade: Array[Upgrade])
signal upgrade_purchased(upgrade_template: Upgrade)
signal tooltip_requested(description: String, spawn_position: Vector2)
signal tooltip_hidden()
signal shop_menu_closed()

#Objectives
signal objective_menu_requested()
signal bookmarked_objective_changed()
signal objective_task_completed(objective_title: String)

#Doing tricks
signal generated_fly_in_text(text: String, position: Vector2, direction: Vector2)
signal combo_completed(combo_name: String)
signal combo_button_pressed(combo_button: Globals.ComboButtons)
signal combo_reset()

# Coaster events
signal station_stop()
signal station_exit()
