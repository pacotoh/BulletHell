extends Node2D

@onready var score: Label = get_node("Score")
# FIXME: This is creating a new instance, not accessing the already created one
@onready var player: CharacterBody2D = preload("res://scenes/player/player.tscn").instantiate()

func _ready():
	score.text = "Final Score: " + str(Game.player_score)


func _on_retry_pressed():
	player.reset_score()
	player.reset_health()
	get_tree().change_scene_to_file("res://scenes/player/world.tscn")
