class_name Enemy
extends Paddle

@export var ball: Ball


func _physics_process(delta: float) -> void:
	direction = (ball.position - position).normalized()
	
	super(delta)

