extends Node

var bullet_scene: PackedScene = preload("res://scenes/mobs/dryad_bullet.tscn")
var pool_size: int = 5
var bullet_pool: Array = []

func _ready() -> void:
	for i in range(pool_size):
		var bullet: Node = bullet_scene.instantiate()
		bullet.hide()
		bullet_pool.append(bullet)
		self.add_child(bullet)


func get_bullet() -> Node:
	for bullet in bullet_pool:
		if bullet != null and not bullet.visible:
			bullet.show()
			return bullet
	
	var bullet: Node = bullet_scene.instantiate()
	bullet_pool.append(bullet)
	bullet.show()
	self.add_child(bullet)
	return bullet
	
	
func reset_bullet(bullet: Node) -> void:
	bullet.global_position = Vector2(-1000, -1000)
	bullet.hide()

