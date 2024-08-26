extends CharacterBody2D

signal morreu

const SPEED = 150.0 #velocidade de movimento
const JUMP_VELOCITY = -350.0 #velocidade do pulo
const wall_jump_pushback = 100
const wall_slide_gravity= 100

var life_player = 3
var pulando = false
var is_takingDamage = false
var is_wall_sliding = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") #gravidade no corpo


func _physics_process(delta): #adicionando gravidade adaptado
	# Add the gravity.
	if not is_on_floor():#(se não) 
		velocity.y += gravity * delta #velocidade da gravidade com adaptação
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() && !is_takingDamage: #(se) acrescentando a uma tecla
		velocity.y = JUMP_VELOCITY #aplicando pulo ao eixo y
		pulando = true
	elif is_on_floor():
		pulando = false
		
	var direction = Input.get_axis("ui_left", "ui_right") #movimentação: esquerda, direita


	wall_slide(delta)
#movimento
	if direction && !is_takingDamage: #(se) lendo direção no eixo x
		velocity.x = direction * SPEED #adicionando velocidade de movimento
		$"animacao".scale.x = direction
	else:#(senão) 
		velocity.x = move_toward(velocity.x, 0, SPEED * 0.08) #adicionando movimentação da direção no eixo x


##ANIMAÇÂO
	if !is_takingDamage:
		if is_on_floor():
			if pulando:
				print(pulando)
				$animacao.play("jump")
			elif direction !=0:
				$"animacao".play("run")
			elif direction == 0:
				$animacao.play("idle")	
		else:
			if velocity.y < 0:
				$animacao.play("jump")
			else:
				$animacao.play("fall")
	move_and_slide()


	if !is_takingDamage:
		if is_on_wall() and Input.is_action_just_pressed("ui_right"):
			velocity.y = JUMP_VELOCITY
			velocity.x = -wall_jump_pushback
		if is_on_wall() and Input.is_action_just_pressed("ui_left"):
			velocity.y = JUMP_VELOCITY
			velocity.x = wall_jump_pushback
		
func wall_slide(delta):
	if is_on_wall() and !is_on_floor():
		if Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right"):
			is_wall_sliding = true
		else:
			is_wall_sliding = false
	else:
		is_wall_sliding = false
	if is_wall_sliding:
		velocity.y += (wall_slide_gravity * delta)
		velocity.y = min(velocity.y, wall_slide_gravity )

func _levouDano(dano):
	is_takingDamage = true
	velocity.x = -400
	#animação de dano
	$animacao.play("hit")
	await $animacao.animation_finished
	is_takingDamage = false
	#subtraindo a vida após o dano
	life_player -= dano
	#caso vida chegue a 0
	if life_player <= 0:
		emit_signal("morreu")
