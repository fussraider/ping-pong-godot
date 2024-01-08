class_name Paddle
extends StaticBody2D

@export var speed: int = 500
@export var wallTop: StaticBody2D
@export var wallBottom: StaticBody2D
@export var camera: Camera2D

@onready var sprite: Sprite2D = $Sprite2D

var direction: Vector2 = Vector2.ZERO
var padHeight: float
var clampTop: float
var clampBottom: float


func _ready() -> void:
	var screenHeight = get_viewport_rect().size.y
	var cameraZoomCorrection: float = screenHeight * (1 - camera.zoom.y)
	
	clampTop = wallTop.position.y + cameraZoomCorrection
	clampBottom = wallBottom.position.y - cameraZoomCorrection
	
	padHeight = sprite.get_rect().size.y * sprite.scale.y


func _physics_process(delta: float) -> void:
	direction.x = 0
	position += speed * delta * direction
	position.y = clamp(position.y, clampTop, clampBottom)

