extends Node2D

enum Scene {
	IntroScreen,
	MainMenu,
	Level,
}

@onready var scenes: Dictionary = {
	Scene.IntroScreen: preload("res://scenes/levels/intro_screen.tscn"),
	Scene.MainMenu: preload("res://scenes/levels/main_menu.tscn"),
	Scene.Level: preload("res://scenes/levels/test_level.tscn"),
}

@onready var screen: SubViewport = get_node("/root/main/screen_container/screen")

signal scene_changed(old_scene: String, new_scene: Scene)

var current_scene: String

func change_scene(scene_type: Scene) -> void:
	var fader: BaseUI = UIManager.open_ui(UIManager.UI.Fader)
	var fader_animator: AnimationPlayer = fader.get_node("animator")
	var old_scene = get_tree().current_scene
	await fader_animator.animation_finished
	for child in screen.get_children():
		screen.remove_child(child)
	var instanced_scene = scenes[scene_type].instantiate()
	screen.add_child(instanced_scene)
	UIManager.close_ui(UIManager.UI.Fader)
	current_scene = instanced_scene.name
	await fader_animator.animation_finished
	scene_changed.emit(old_scene, scene_type)
