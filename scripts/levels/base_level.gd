extends Node2D

@onready var player: Actor = $player

func _ready() -> void:
	UIManager.initialize_in_game_uis()
