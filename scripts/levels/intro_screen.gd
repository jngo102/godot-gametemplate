extends Control

@onready var animator: AnimationPlayer = $animator

func _ready() -> void:
	animator.play("start")
	await animator.animation_finished
	SceneManager.change_scene(SceneManager.Scene.MainMenu)
