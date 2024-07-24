extends Node

var mob_scene: PackedScene = preload("res://scenes/mobs/dryad.tscn")
@onready var cooldown: Node = get_node("Timer")
var pool_size: int = 10
var mob_pool: Array = []


func _ready() -> void:
	for i in range(pool_size):
		var mob: Node = mob_scene.instantiate()
		mob.hide()
		mob_pool.append(mob)
		self.add_child(mob) 


func get_mob() -> Node:
	for mob in mob_pool:
		if mob != null and not mob.visible and mob.is_alive:
			return mob
	
	var new_mob: Node = mob_scene.instantiate()
	new_mob.hide()
	mob_pool.append(new_mob)
	add_child(new_mob)
	return new_mob
	
	
func reset_mob(mob: Node) -> void:
	mob.is_alive = false
	mob.hide()
	mob.position = Vector2(-1000, -1000)


func _on_timer_timeout() -> void:
	var mob: Node = get_mob()
	var randX: int = randi_range(-20, 20)
	var randY: int = randi_range(-20, 20)
	mob.global_position = self.global_position + Vector2(randX, randY)
	mob.show()
