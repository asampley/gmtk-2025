extends Node

signal debug(text: String)


signal debug_collision_position(position: Vector2)
signal requested_save_data_reset()
signal audio_clip_requested(clip: AudioStream)
signal screen_shake_increased(amount: float)

#Upgrade Purchasing
signal upgrade_menu_opened(upgrade: Array[Upgrade])
signal upgrade_unlocked(upgrade_name: String)
signal upgrade_purchased(upgrade: Upgrade)
signal tooltip_requested(description: String, spawn_position: Vector2)
signal tooltip_hidden()
signal shop_menu_closed()

#Objectives
signal objective_menu_requested()
signal bookmarked_objective_changed()
signal bookmarked_objective_updated()
signal objective_task_completed(objective_title: String)

#Doing tricks
signal generated_fly_in_text(text: String, position: Vector2, direction: Vector2)
signal combo_button_pressed(combo_button: Globals.ComboButtons, length: int)
signal combo_completed(current_score: float, current_mult: float)
signal combo_failed()
signal combo_reset()

# Coaster events
signal station_stop()
signal station_exit()

#UI
signal money_amount_changed(money: int)
signal speed_update(speed: float)
signal airtime_changed(airtime: float)
