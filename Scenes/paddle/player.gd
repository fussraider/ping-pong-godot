class_name Player
extends Paddle


func _physics_process(delta: float) -> void:
	var axisDirection: float = Input.get_axis("ui_up", "ui_down")
	
	if axisDirection:
		direction.y = axisDirection
	else:
		direction.y = move_toward(direction.y, 0, speed)
		
	super(delta)

