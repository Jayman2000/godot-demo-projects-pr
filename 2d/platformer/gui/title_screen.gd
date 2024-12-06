extends Node


func _enter_tree() -> void:
	$VBoxContainer/Title.text = ProjectSettings.get_setting("application/config/name")


func _on_play_buttton_pressed() -> void:
	get_tree().change_scene_to_packed(preload("res://game_singleplayer.tscn"))


func _on_quit_button_pressed() -> void:
	get_tree().quit()
