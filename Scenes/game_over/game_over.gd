class_name GameOver
extends CanvasLayer

@export var is_win: bool = false

@onready var resultLabel: Label = $%ResultLabel
@onready var restartBtn: Button = $%RestartButton


func _ready() -> void:
	if is_win:
		resultLabel.text = "YOU WIN!"
	else:
		resultLabel.text = "GAME OVER"
		
	restartBtn.connect("pressed", on_restart_button_pressed)


func on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()

