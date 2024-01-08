class_name UI
extends CanvasLayer

@onready var playerScore: Label = $%PlayerScore
@onready var enemyScore: Label = $%EnemyScore


func _ready() -> void:
	set_player_score(0)
	set_enemy_score(0)


func set_player_score(value: int) -> void:
	playerScore.text = str(value)


func set_enemy_score(value: int) -> void:
	enemyScore.text = str(value)

