extends CharacterBody2D

var speed: int = 75
var direction: Vector2 = Vector2(0, 1)
@onready var player: Sprite2D = $Player
@onready var bullet_pool: Node = get_node("Bullets")


func _ready() -> void:
	player.frame = 0


func update_health() -> void:
	Game.player_health -= 1
	
func update_score() -> void:
	Game.player_score += 1


func reset_health() -> void:
	Game.player_health = 5


func reset_score() -> void:
	Game.player_score = 0


func _physics_process(_delta: float) -> void:
	var inputDir: Vector2 = Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")		
	)
	
	if inputDir.x > 0:
		player.frame = 1
		player.flip_h = false
		direction = inputDir
	elif inputDir.x < 0:
		player.frame = 1
		player.flip_h = true
		direction = inputDir
	elif inputDir.y > 0:
		player.frame = 0
		player.flip_h = false
		direction = inputDir
	elif inputDir.y < 0:
		player.frame = 2
		player.flip_h = false
		direction = inputDir

	$SpawnPoint.position = direction
	
	if Input.is_action_just_pressed("shoot"):
		var bulletTemp: Node = bullet_pool.get_bullet()
		bulletTemp.velocity = direction * 100
		bulletTemp.global_position = $SpawnPoint.global_position
		
	velocity = inputDir * speed
	move_and_slide()
	
	if Game.player_health < 1:
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
