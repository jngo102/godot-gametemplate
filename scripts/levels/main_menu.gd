extends Control

@onready var quit_button: Button = $margin_container/menu_buttons/quit_button

func _ready() -> void:
	match OS.get_name():
		"Windows", "macOS", "Linux":
			quit_button.show()
			
	if UIManager.get_ui(UIManager.UI.PauseMenu) != null:
		UIManager.free_ui(UIManager.UI.PauseMenu)
	
func _on_settings_button_pressed() -> void:
	pass # Replace with function body.

func _on_start_button_pressed() -> void:
	SceneManager.change_scene(SceneManager.Scene.Level)

func _on_quit_button_pressed() -> void:
	get_tree().quit()
