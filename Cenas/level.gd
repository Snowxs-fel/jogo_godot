extends Node2D
@onready var player = $Player


func _ready():
	player.morreu.connect(_ResetGame)
	Global.pontos = 0

func _ResetGame():
	get_tree().reload_current_scene()
