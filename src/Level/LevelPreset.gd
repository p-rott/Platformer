class_name Level
extends Node2D

#Camera limits
const LIMIT_LEFT = -315
const LIMIT_TOP = -250
const LIMIT_RIGHT = 2000
const LIMIT_BOTTOM = 950
onready var player = $Player
onready var playerSpawn = $ControlNodes/PlayerSpawn
onready var pauseMenu = $CanvasLayer/PauseMenu
onready var levelEndscreen = $CanvasLayer/LevelEndscreen

var attemptStartTime : int
var attemptEndTime : int
var deathCount = 0

func _ready():
	var camera = player.get_node("Camera")
	camera.limit_left = LIMIT_LEFT
	camera.limit_top = LIMIT_TOP
	camera.limit_right = LIMIT_RIGHT
	camera.limit_bottom = LIMIT_BOTTOM
	spawnPlayer()

func resetLevel():
	for child in $Traps.get_children():
		if child is FallingPlatform:
			child.reset()
		elif child is LaserEmitterGroup:
			child.setTimers()
		elif child is LaserEmitter:
			child.setTimersAndStart()

func spawnPlayer():
	print("spawn player")
	resetLevel()
	var s = playerSpawn.getSpawn()
	player.spawn(s)
	attemptStartTime = OS.get_ticks_msec()

func playerDeath():
	#death statistics/time etc
	deathCount = deathCount + 1
	spawnPlayer()

func playerGoal():
	attemptEndTime = OS.get_ticks_msec()
	levelEndscreen.open()

#overriden in each level
func nextLevel():
	pass

func gotToMainMenu():
	levelEndscreen.hide()
	Global.goto_startscreen()
