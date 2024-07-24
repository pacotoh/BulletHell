extends ProgressBar

@onready var player: CharacterBody2D = $"../../Player"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	max_value = Game.player_health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	value = Game.player_health
