class_name Game
extends Node2D

@export var maxScore = 5

@onready var player: Player = $Player
@onready var enemy: Enemy = $Enemy
@onready var ball: Ball = $Ball
@onready var edgeLeft: Edge = $EdgeLeft
@onready var edgeRight: Edge = $EdgeRight
@onready var ui: UI = $UI

var playerScore: int = 0
var enemyScore: int = 0
var gameOverScene: PackedScene = preload("res://Scenes/game_over/game_over.tscn")


func _ready() -> void:
	edgeLeft.connect("ball_entered", on_edge_left_ball_entered)
	edgeRight.connect("ball_entered", on_edge_right_ball_entered)

func on_edge_right_ball_entered() -> void:
	playerScore += 1
	ui.set_player_score(playerScore)
	if !check_game_over():
		ball.reset()


func on_edge_left_ball_entered() -> void:
	enemyScore += 1
	ui.set_enemy_score(enemyScore)
	if !check_game_over():
		ball.reset()


func check_game_over() -> bool:
	if playerScore >= maxScore:
		game_over(true)
		return true
	elif enemyScore >= maxScore:
		game_over(false)
		return true
		
	return false


func game_over(is_win: bool) -> void:
	var gameOver: GameOver = gameOverScene.instantiate()
	gameOver.is_win = is_win
	
	player.queue_free()
	enemy.queue_free()
	ball.queue_free()
	
	add_child(gameOver)

