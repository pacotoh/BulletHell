extends Label


func _process(_delta: float) -> void:
	self.text = "Score: " + str(Game.player_score)
