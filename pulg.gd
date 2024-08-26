extends CharacterBody2D

class_name Pulg
@onready var player = $"../Player"


const speed = 100
@export var is_pulg_chase : bool = false

var health = 80
var health_max = 80
var health_min = 0

var dead: bool = false
var taking_damage : bool = false
var damage_to_deal = 20
var is_dealing_damage: bool = false

var dir: Vector2
const gravity = 900
var knockback_force = 200
var is_roaming: bool = true
@onready var Raycasts = $Raycasts
func _process(delta: float) -> void:
	for raycast in Raycasts.get_children():
		raycast.force_raycast_update() 
		if raycast.is_colliding():
			if raycast == $Raycasts/Rightraycast:
				dir = Vector2.LEFT
			elif raycast == $Raycasts/Leftraycast:
				dir = Vector2.RIGHT
	if is_on_floor():
		$Sprite2D2.visible = true
	else:
		$Sprite2D2.visible = false
	if !is_on_floor():
		velocity.y += gravity * delta
		velocity.x = 0
	move(delta)
	handle_animation()
	move_and_slide()

func handle_animation():
	var animplayer = $AnimationPlayer
	if !dead && !taking_damage && !is_dealing_damage:
		if velocity.x != 0:
			animplayer.play("walking")
		if velocity.x == 0:
			animplayer.play("idle")
		if dir.x == -1:
			$Sprite2D.flip_h = false
		elif dir.x == 1:
			$Sprite2D.flip_h = true
	
func move(delta):
	if !dead:
		if !is_pulg_chase:
			velocity += dir * speed * delta
		#elif is_pulg_chase and !taking_damage:
			#var dir_to_player = position.direction_to(player.position) * speed
			#velocity.x = dir_to_player.x
			#dir.x = abs(velocity.x) / velocity.x
		#is_roaming = true
	#elif dead:
		#velocity.x = 0
func _on_directiontimer_timeout() -> void:
	$Directiontimer.wait_time = choose([3])
	if !is_pulg_chase:
		dir = choose([Vector2.RIGHT, Vector2.LEFT])
		velocity.x = 0
func choose(array):
	array.shuffle()
	return array.front()


func damage():
	print("hit")


