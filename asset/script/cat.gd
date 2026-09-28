extends CharacterBody2D
@onready var player: CharacterBody2D = $"../../player"
@onready var ysort: Node2D = $"../.."
@onready var catCollision = $Area2D/detectCollision
@onready var collisionBody: Area2D = $Area2D
@onready var energyBar: TextureProgressBar = $"../../../TextureProgressBar"

var SPEED = 50
var catPosition = Vector2.ZERO

func follow_player():
	var Pposition = player.pPosition 
	var direct
	catPosition = global_position
	direct = Pposition - catPosition
	velocity = direct.normalized() * SPEED

func reduce_energy_collision():
	var colision = collisionBody.has_overlapping_bodies()
	if colision == true:
		print('reduce')
		energyBar.value -= 1

func _physics_process(_delta: float) -> void:
	reduce_energy_collision()
	follow_player()
	move_and_slide()
	
