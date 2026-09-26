extends CharacterBody2D
@export var SPEED = 100

var pPosition = Vector2.ZERO

func get_input():
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	#var last_move = Vector2.ZERO
	pPosition = global_position
	velocity = input_direction * SPEED
	
	#if input_direction != Vector2.ZERO:
		#last_move = input_direction
		
	if Input.is_action_pressed("move_down"):
		$AnimatedSprite2D.play("move_forward")
	if Input.is_action_pressed("move_up"):
		$AnimatedSprite2D.play("move_back")
	if Input.is_action_pressed("move_right"):
		$AnimatedSprite2D.play("move_left_right")
		$AnimatedSprite2D.flip_h = false
	if Input.is_action_pressed("move_left"):
		$AnimatedSprite2D.play("move_left_right")
		$AnimatedSprite2D.flip_h = true
	if input_direction == Vector2.ZERO:
		$AnimatedSprite2D.stop()

	#to idle last move
	#if input_direction != Vector2.ZERO:
		#last_move = input_direction
	#if input_direction == Vector2.ZERO and last_move == Vector2.ZERO:
		#$AnimatedSprite2D.play("idle")
	#if input_direction == Vector2.ZERO:
		#if last_move == Vector2.RIGHT:
			#$AnimatedSprite2D.stop()
			#$AnimatedSprite2D.play("idle_right")
			#print(input_direction)
			#print(last_move)


func _physics_process(_delta: float) -> void:
	get_input()
	move_and_slide()
