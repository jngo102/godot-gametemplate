extends Control

func _ready() -> void:
	if UIManager.get_ui("pause_menu") != null:
		UIManager.free_ui("pause_menu")

func _on_settings_button_pressed() -> void:
	pass # Replace with function body.

func _on_start_button_pressed() -> void:
	SceneManager.change_scene("level")
