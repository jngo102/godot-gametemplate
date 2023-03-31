extends BaseUI

@onready var animator: AnimationPlayer = $animator
@onready var background_blur: TextureRect = $background_blur
@onready var margin_container: MarginContainer = $margin_container
@onready var menu_buttons: VBoxContainer = margin_container.get_node("menu_buttons")
@onready var quit_warning: VBoxContainer = margin_container.get_node("quit_warning")

var can_close: bool

func _ready() -> void:
	background_blur.texture = get_viewport().get_texture()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if is_open:
			close()
		else:
			open()
			
func open() -> void:
	super.open()
	animator.play("open")
	
func close() -> void:
	animator.play("close")
	
func pause(do_pause: bool = true) -> void:
	get_tree().set_pause(do_pause)

func _on_animator_animation_finished(anim_name: String) -> void:
	if anim_name == "open":
		can_close = true
	elif anim_name == "close":
		super.close()

func _on_resume_button_pressed() -> void:
	close()

func _on_settings_button_pressed() -> void:
	pass

func _on_quit_button_pressed() -> void:
	menu_buttons.hide()
	quit_warning.show()

func _on_quit_confirm_pressed() -> void:
	close()
	SceneManager.change_scene("main_menu")

func _on_quit_cancel_pressed() -> void:
	quit_warning.hide()
	menu_buttons.show()
