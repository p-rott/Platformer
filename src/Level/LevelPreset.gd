class_name Level
extends Node2D

const LIMIT_LEFT = -315
const LIMIT_TOP = -250
const LIMIT_RIGHT = 2000
const LIMIT_BOTTOM_DICT = {"Roof0":750, "Roof1":980, "Roof2":800, "Roof3":1000, "Roof4":750, "Start":1000}
onready var player = $Player
onready var playerSpawn = $ControlNodes/PlayerSpawn
onready var pauseMenu = $CanvasLayer/PauseMenu
onready var levelEndscreen = $CanvasLayer/LevelEndscreen
onready var traps = $Traps
onready var platforms = $Platforms
onready var WorldEnviromnent:WorldEnvironment = $WorldEnvironment 

var attemptStartTime : int
var attemptEndTime : int
var deathCount = 0
export var setPlayerCurrentCamera = true

func _ready():
	if setPlayerCurrentCamera:
		$Player/Camera.current = true
	var camera = player.get_node("Camera")
	camera.limit_left = LIMIT_LEFT
	camera.limit_top = LIMIT_TOP
	camera.limit_right = LIMIT_RIGHT
	camera.limit_bottom = LIMIT_BOTTOM_DICT[name.substr(0,5)]
	spawnPlayer()
	levelEndscreen.levelName = name

func resetLevel():
	for child in platforms.get_children():
		if child is FallingPlatform:
			child.reset()
	for child in traps.get_children():
		if child is LaserEmitter or child is LaserEmitterGroup:
			child.setTimersAndStart()

func spawnPlayer():
	resetLevel()
	var s = playerSpawn.getSpawn()
	player.spawn(s)
	attemptStartTime = OS.get_ticks_msec()

func playerDeath():
	deathCount = deathCount + 1
	spawnPlayer()

func playerGoal():
	attemptEndTime = OS.get_ticks_msec()
	Global.set_level_deaths(name, Global.get_level_deaths(name) + deathCount)
	var currentTime = attemptEndTime - attemptStartTime
	var bestTime = Global.get_level_time(name)
	if bestTime == null or currentTime < bestTime:
		Global.set_level_time(name, currentTime)
	levelEndscreen.open(currentTime)

func nextLevel():
	var nextId = name.to_int() + 1
	if nextId == 5:
		Global.goto_victoryscreen()
	else:
		var nextLevelname = "Roof" + str(nextId)
		Global.goto_scene("res://src/Level/areas/Levels/" + nextLevelname + ".tscn")

func gotToMainMenu():
	levelEndscreen.hide()
	Global.goto_startscreen()
