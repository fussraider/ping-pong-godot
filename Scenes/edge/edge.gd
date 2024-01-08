class_name Edge
extends Area2D

signal ball_entered


func _ready() -> void:
	connect("body_entered", on_edge_body_entered)


func on_edge_body_entered(body: Node2D) -> void:
	if body is Ball:
		ball_entered.emit()
