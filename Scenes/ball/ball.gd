class_name Ball
extends CharacterBody2D

@export var initialSpeed: float = 500.0
@export var speedMultiplier: float = 1.02
@export var velocityRange: Vector2 = Vector2(1, 0.8)
@export var maxYVector: float = 0.6

@onready var stuckCheckTimer: Timer = $StuckCheckTimer
@onready var sprite: Sprite2D = $Sprite2D

var speed: float
var startPosition: Vector2
var lastPosition: Vector2

func _ready() -> void:
	startPosition = get_viewport_rect().get_center()
	lastPosition = startPosition
	stuckCheckTimer.connect("timeout", on_stuck_check_timer_timeout)
	
	reset()


func _physics_process(delta: float) -> void:
	
	var collision: KinematicCollision2D = move_and_collide(velocity * speed * delta)
	
	if collision:
		var collider: Object = collision.get_collider()
		
		if collider is Paddle:
			speed *= speedMultiplier 
			velocity = new_velocity(collider)
		else:
			velocity = velocity.bounce(collision.get_normal())
 

func reset() -> void:
	position = startPosition
	speed = initialSpeed
	random_velocity()


func random_velocity() -> void:
	var randomVelocity: Vector2 = Vector2(
		[-velocityRange.x, velocityRange.x].pick_random(), 
		[-velocityRange.y, velocityRange.y].pick_random()
	);
	
	velocity = (randomVelocity * initialSpeed).normalized()


func new_velocity(collider: Paddle) -> Vector2:
	var centerDistance: float = position.y - collider.position.y
	var newDirection: Vector2 = Vector2.ZERO
	
	if velocity.x > 0:
		newDirection.x = -1
	else:
		newDirection.x = 1
	
	newDirection.y = (centerDistance / (collider.padHeight / 2)) * maxYVector
	
	return newDirection.normalized()


func on_stuck_check_timer_timeout() -> void:
	if abs(position.x - lastPosition.x) < speed * get_physics_process_delta_time():
		position.x += sprite.texture.get_size().x * sprite.scale.x
	else:
		lastPosition = position

