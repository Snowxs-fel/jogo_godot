extends Area2D
@onready var player = $"../../Player"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	if body.name == "Player":
		#queue_free() # Replace with function body..
		
		player._levouDano(1)
#		get_tree().reload_current_scene()

