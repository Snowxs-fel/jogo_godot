extends Area2D

@onready var control = $"../HUD/Control"


func _on_body_entered(body):
	control.segundos += 10 #adiciona mais 10 seg no temporizador do game
	await $CollisionShape2D.call_deferred("queue_free")
	queue_free() #faz o ícone do item sumir
