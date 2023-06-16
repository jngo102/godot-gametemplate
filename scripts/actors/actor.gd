extends CharacterBody2D
class_name Actor

@export var move_speed: float = 250

@onready var animator: AnimationPlayer = $animator
@onready var sprite: Sprite2D = $sprite
@onready var collision: CollisionShape2D = $collision

var anim_name: String = "Idle Down"
var direction: Vector2

func _process(delta: float) -> void:
	set_anim()

func _physics_process(delta: float) -> void:
	move()
	
func move() -> void:
	velocity = velocity.normalized() * move_speed
	move_and_slide()
	
func set_anim():
	if velocity.x > 0:
		transform.x.x = 1
		anim_name = "Walk Side"
	elif velocity.x < 0:
		transform.x.x = -1
		anim_name = "Walk Side"
	if velocity.y > 0:
		anim_name = "Walk Down"
	elif velocity.y < 0:
		anim_name = "Walk Up"
	if velocity.length() <= 0:
		anim_name = anim_name.replace("Walk", "Idle")
	# animator.play(anim_name)
