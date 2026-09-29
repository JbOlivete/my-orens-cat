extends Node2D

@onready var milkTeaSpawnPoint: Marker2D = $ysort/milkteaSpawnPoint
@onready var playerSpeed: CharacterBody2D = $ysort/player
@onready var speedDuration: Timer = $ysort/speedduration
@onready var respawnMilkTea: Timer = $ysort/milkteaRespawn
@onready var milkTea: Area2D = $ysort/milkteaSpawnPoint/Milktea
@onready var collision: CollisionShape2D = $ysort/milkteaSpawnPoint/Milktea/milkteaCollision
@onready var energyBar: TextureProgressBar = $TextureProgressBar
@onready var endGameMenu: Control = $EndGamePopup
@onready var retryBtn: MenuButton = $EndGamePopup/retry
@onready var catCount: MenuButton = $EndGamePopup/numberofcats
@onready var timeSurviveMenu: MenuButton = $EndGamePopup/timeofsurvive
@onready var surviveTimer: Timer = $surviveTimer
@onready var surviveTimerLabel: Label = $timer
@onready var spawnPoint: Marker2D = $ysort/spawnpoint
@onready var mudspawnPoint: Marker2D = $ysort/Mudspawnpoint

var spawnCat = preload("res://asset/scene/cat.tscn")
var milktea = preload("res://asset/scene/milktea.tscn")
var mud = preload("res://asset/scene/mud.tscn")

var rng = RandomNumberGenerator.new()
#timer label variable
var timerCounter = 0
var secFirstNum = 0
var secSecondNum = 0
var minutesFirstNum = 0
var minutesSecondNum = 0
var hour = 0
var catCounter = 0

func generateRandomLoc():
	var yaxis = rng.randf_range(-250.0, 50.0)
	var xaxis = rng.randf_range(50.0, 550.0)
	var milkTeaSpawnLoc = Vector2(xaxis, yaxis)
	return milkTeaSpawnLoc
	
func toInstantiateMilkTea(randomloc):
	milkTeaSpawnPoint.global_position = randomloc
	var addMilktea = milktea.instantiate()
	milkTeaSpawnPoint.add_child(addMilktea)
	print(randomloc)
	
func toInstantiateMud(randomloc):
	mudspawnPoint.global_position = randomloc
	var addMud = mud.instantiate()
	mudspawnPoint.add_child(addMud)
	print(randomloc)
	
func addSpeed():
	var addedSpeed = playerSpeed.SPEED
	addedSpeed *= 0.3
	playerSpeed.SPEED += addedSpeed
	print('+ 30percent speed')
	return addedSpeed

func set_time_label():
	var secondSecNum = str(secSecondNum)
	var firstSecNum = str(secFirstNum)
	var secondMinNum = str(minutesSecondNum)
	var firstMinNum = str(minutesFirstNum)
	var hr = str(hour)
	
	surviveTimerLabel.text[6] = secondSecNum
	surviveTimerLabel.text[5] = firstSecNum
	surviveTimerLabel.text[3] = secondMinNum
	surviveTimerLabel.text[2] = firstMinNum
	surviveTimerLabel.text[0] =  hr

func run_time():
	timerCounter += 1
	secSecondNum = timerCounter
	if secSecondNum == 10:
		secFirstNum += 1
		timerCounter = 0
		secSecondNum = timerCounter
	if secFirstNum == 6 and secSecondNum == 0:
		minutesSecondNum += 1
		secFirstNum = 0
		secSecondNum = 0
	if minutesSecondNum == 10:
		minutesFirstNum += 1
		minutesSecondNum = 0
	if minutesFirstNum == 6 and minutesSecondNum == 0:
		hour += 1
		minutesFirstNum = 0
		minutesSecondNum = 0

func set_timeSurvive_onMenu():
	timeSurviveMenu.text = surviveTimerLabel.text

func show_menu():
	if energyBar.value == 0:
		endGameMenu.visible = true

func set_Catcount():
	catCount.text = str(catCounter)

func pause_game():
	if energyBar.value == 0:
		get_tree().paused = true
		show_menu()
		
#signal
func _on_cat_timer_spawn_timeout() -> void:
	var addCat 
	catCounter += 1
	addCat = spawnCat.instantiate()
	spawnPoint.add_child(addCat)
	print(catCounter)

func _on_milktea_body_entered(body: Node2D) -> void:
	milkTeaSpawnPoint.hide()
	collision.set_deferred("disabled", true)
	respawnMilkTea.start()
	speedDuration.start()
	addSpeed()
	print('duration speed', playerSpeed.SPEED)

func _on_speedduration_timeout() -> void:
	playerSpeed.SPEED -= 30
	print('after subtract',playerSpeed.SPEED)
	#playerSpeed.SPEED -= 30
	#print('timeout speed',playerSpeed.SPEED)
	print('timeout')

func _on_milktea_respawn_timeout() -> void:
	var randomloc = generateRandomLoc()
	toInstantiateMilkTea(randomloc)
	milkTeaSpawnPoint.show()
	collision.set_deferred("disabled", false)
	print('timeout respawn')

func _on_survive_timer_timeout() -> void:
	run_time()

func _on_retry_pressed() -> void:
	if retryBtn.button_pressed == true:
		get_tree().paused = false
		get_tree().reload_current_scene()
	
func _ready() -> void:
	var mtRandomLoc = generateRandomLoc()
	var mudRandomLoc = generateRandomLoc()
	toInstantiateMilkTea(mtRandomLoc)
	toInstantiateMud(mudRandomLoc)
	surviveTimer.start()

func _physics_process(delta: float) -> void:
	set_Catcount()
	set_time_label()
	set_timeSurvive_onMenu()
	pause_game()
