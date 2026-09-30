extends Area2D

@onready var mudArea2d: Area2D = $"."
@onready var playerCharacter: CharacterBody2D = $"../../../player"
@onready var slowDuration: Timer = $"../../../mudSlowduration"
@onready var collisionShape: CollisionShape2D = $CollisionShape2D
func reduce_speed():
	if mudArea2d.has_overlapping_bodies() == true:
		playerCharacter.SPEED -= 10
		collisionShape.set_deferred("disabled", true)
		slowDuration.start()
		print('Speed after collision on mud', playerCharacter.SPEED)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	reduce_speed()
