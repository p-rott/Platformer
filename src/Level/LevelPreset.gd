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
	levelEndscreen.levelName = name

func resetLevel():
	for child in $Traps.get_children():
		if child is FallingPlatform:
			child.reset()
		elif child is LaserEmitterGroup:
			child.setTimers()
		elif child is LaserEmitter:
			child.setTimersAndStart()

func spawnPlayer():
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
	Global.set_level_deaths(name, Global.get_level_deaths(name) + deathCount)
	var currentTime = attemptEndTime - attemptStartTime
	var bestTime = Global.get_level_time(name)
	if currentTime < bestTime:
		Global.set_level_time(name, currentTime)
	levelEndscreen.open(currentTime)

func nextLevel():
	var nextId = name.to_int() + 1
	var bSide = false
	if nextId == 4 and bSide == true:
		#TODO game won
		Global.goto_startscreen()
	elif nextId == 4:
		nextId = 0
		bSide = true
	var nextLevelname = "Roof" + str(nextId) + ("B" if bSide else "")
	Global.goto_scene("res://src/Level/areas/1/" + nextLevelname + ".tscn")

func gotToMainMenu():
	levelEndscreen.hide()
	Global.goto_startscreen()
