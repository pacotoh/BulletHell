extends CharacterBody2D

const MAX_VALUE: int = 600
const MIN_VALUE: int = 0


func _process(_delta: float):
	move_and_slide() 
	
	if self.position.x > MAX_VALUE or self.position.x < MIN_VALUE or self.position.y > MAX_VALUE or self.position.y < MIN_VALUE:
		self.queue_free() 

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		if body.visible and self.visible:
			get_parent().reset_bullet(self)
			body.update_health()
