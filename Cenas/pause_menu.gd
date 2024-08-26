extends CanvasLayer

var game_paused = false

func _ready():
	visible = false

func _on_quit_bt_pressed():
	get_tree().quit() #sair do game
	

func _on_reiniciar_bt_pressed():
	get_tree().change_scene_to_file("res://Cenas/level.tscn")


func _on_voltar_bt_pressed():
	get_tree().paused = false
	visible = false

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		game_paused = !game_paused
		get_tree().paused = game_paused
		visible = game_paused
