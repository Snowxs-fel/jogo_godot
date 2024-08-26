extends Control

@onready var item_contador = $MarginContainer/HBoxContainer/item_contador as Label
@onready var timer_count = $MarginContainer/HBoxContainer/timer_count as Label
@onready var life_count = $MarginContainer/HBoxContainer/life_count as Label
@onready var timer = $Timer as Timer
@onready var player = $"../../Player"
@onready var relogio = $"../../relogio"



signal tempo_acabou()

var minutos = 0
var segundos = 0

#Para limitar o tempo
@export_range(0,2) var min_padrao = 1
@export_range(0,59) var seg_padrao = 0

func _ready():
	item_contador.text = str("%03d" % Global.pontos) #Mostra na tela os pontos do player
	timer_count.text = str("%02d" % min_padrao) + ":" + str("%02d" % seg_padrao)#Mostra na tela o tempo
	life_count.text = str("%02d" % player.life_player)
	
	minutos = min_padrao
	segundos = seg_padrao

func _process(delta):
	item_contador.text = str("%03d" % Global.pontos)
	life_count.text = str("%02d" % player.life_player)
	if minutos == 0 && segundos == 0:
		emit_signal("tempo_acabou")#Emite um sinal falando que o tempo acabou


func _on_timer_timeout():
	if segundos == 0:
		if minutos > 0:
			minutos -=1
			segundos = 60
	segundos -=1 
	if segundos > 60:
		minutos += 1
		segundos = segundos - 60
	if segundos == 0 && minutos == 0:
		player._levouDano(5) 
		


	timer_count.text = str("%02d" % minutos) + ":" + str("%02d" % segundos)


