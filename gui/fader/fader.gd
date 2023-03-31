extends BaseUI

@onready var animator: AnimationPlayer = $animator

func open() -> void:
	super.open()
	animator.play("show")
	
func close() -> void:
	animator.play("hide")
	await animator.animation_finished
	super.close()
