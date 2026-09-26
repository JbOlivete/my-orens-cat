extends Marker2D

#var sppPosition = Vector2.ZERO
#var spawnCat = load("res://asset/scene/cat.tscn").instantiate()
#
#func getsppPosition():
	#sppPosition = global_position.normalized()
	#spawnCat.global_position = sppPosition
	##get_tree().get_root().get_node("game/ysort").add_child(spawnCat)
	#get_tree().current_scene.add_child(spawnCat)
	#print(sppPosition)
#
##func spawnACat():
	##sppPosition.add_child(spawnCat)
##how to instance in this location to cod
#func _physics_process(_delta: float) -> void:
	#getsppPosition()
