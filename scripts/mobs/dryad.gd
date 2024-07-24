extends CharacterBody2D

var is_alive: bool = true
var speed: float = 0.5
var mob: bool = true
var health: int = 2

@onready var player: Node = get_node("../../Player")
@onready var sprite: Sprite2D = get_node("Sprite2D")
@onready var bar: ProgressBar = get_node("ProgressBar")
@onready var collision: CollisionShape2D = get_node("CollisionShape2D")
@onready var death_animation: AnimatedSprite2D = get_node("DeathAnimation")
@onready var dryad_pool: Node = get_node("Bullets")


func _ready() -> void:
	bar.max_value = self.health


func _physics_process(_delta: float) -> void:
	if is_alive:
		bar.value = self.health
		var direction: Vector2 = (player.global_position 
		- self.global_position).normalized()
		velocity = speed * direction
		move_and_collide(velocity)
		sprite.flip_h = not (direction.x < 0)


func update_health() -> void:
	if self.health > 1:
		self.health -= 1
	else:
		self.health = 0
		self.is_alive = false
		death_animation.show()
		death_animation.play("death")
		await death_animation.animation_finished
		self.get_parent().reset_mob(self)
		self.queue_free()
		if not self.is_alive:
			player.update_score()


func _on_shoot_timer_timeout() -> void:
	if self.is_alive:
		var bulletTemp: Node = dryad_pool.get_bullet()
		var direction: Vector2 = (player.global_position 
		- self.global_position).normalized()
		bulletTemp.velocity = direction * 100
		bulletTemp.global_position = $SpawnPoint.global_position
