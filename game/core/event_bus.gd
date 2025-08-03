extends Node

signal debug(text: String)


signal debug_collision_position(position: Vector2)
signal requested_reset_data_popup()
signal requested_save_data_reset()
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
signal objective_claimed()

#Doing tricks
signal generated_fly_in_text(text: String, position: Vector2, direction: Vector2)
signal combo_button_pressed(combo_button: Globals.ComboButtons, length: int)
signal combo_completed(combo_name: String, current_score: float, current_mult: float)
signal combo_failed()
signal combo_reset()

# Coaster events
signal station_stop()
signal station_exit()
signal train_audio_requested(clip: AudioStream)
signal start_train_moving_sound()
signal stop_train_moving_sound()

#UI
signal money_amount_changed(money: int)
signal speed_update(speed: float)
signal airtime_changed(airtime: float)
signal play_ui_sound(sound: AudioStream)
signal glide_cooldown_changed(amount: float)
signal nitro_cooldown_changed(amount: float)
signal nitro_unlocked()

# Game end
signal to_the_moon()
