extends Node2D

@onready var scenes: Dictionary = {
	"intro_screen": preload("res://scenes/intro_screen/intro_screen.tscn"),
	"main_menu": preload("res://scenes/main_menu/main_menu.tscn"),
	# "level": preload("res://scenes/gameplay/gameplay_scene.tscn"),
}

@onready var screen: Viewport = get_node("/root/main/screen_container/screen")

signal scene_changed

var current_scene: String

func change_scene(scene_name: String) -> void:
	var fader: BaseUI = UIManager.open_ui("fader")
	var fader_animator: AnimationPlayer = fader.get_node("animator")
	var old_scene = get_tree().current_scene
	await fader_animator.animation_finished
	for child in screen.get_children():
		screen.remove_child(child)
	var instanced_scene = scenes[scene_name].instantiate()
	screen.add_child(instanced_scene)
	UIManager.close_ui("fader")
	current_scene = scene_name
	await fader_animator.animation_finished
	scene_changed.emit(old_scene, scene_name)
