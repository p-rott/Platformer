class_name Player
extends Actor

const FLOOR_DETECT_DISTANCE = 20.0
export var maxRunSpeed = 300
export var maxFallSpeed = 500
export var maxWallSlideSpeed = 40
export var sprintIncrease = 1.1
export var jumpAccelerationDecrease = 0.2
export var acceleration = 75
export var changeMoveDirectionTempo = 0
export var jump_buffer_time_ms = 50 #When Jump is pressed while in Air, the jump is still executed if the player touches the ground in this time
var jump_buffer_time_s = jump_buffer_time_ms / 1000
var jump_buffer = 0 # is set when jump is pressed in the air

export var coyote_time_ms = 50 #time it is possible to jump after falling of an edge
var coyote_time_s : float
export(float, 0,1) var jump_cancel_factor = 0 # When zero, jump ist instantly canceled

export(float, 0,1) var grounded_hDamping = 1 #Factor how much the movement is damped when stopping, 1 for instant stop
export(float, 0,1) var jumping_hDamping = 1 #Factor how much the horizontalmovement while jumping is damped when stopping, 1 for instant stop
export(float, 0,1) var falling_hDamping = 1 #Factor how much the horizontalmovement while falling is damped when stopping, 1 for instant stop
var state : State
var state_factory

onready var platform_detector = $PlatformDetector
onready var wall_detector_left = $WallDetectorLeft
onready var wall_detector_right = $WallDetectorRight
onready var animation_player = $AnimationPlayer
onready var sprite = $Sprite
onready var trail = $Trail 
onready var puff = $Puff
func _ready():
	coyote_time_s = coyote_time_ms / 1000.0
	var camera: Camera2D = $Camera
	camera.custom_viewport = $"../.."
	state_factory = StateFactory.new()
	setIdleState()

func spawn(pos: Vector2):
	position = pos
	_velocity = Vector2.ZERO
	change_state("spawn")

func informLevelOfDeath():
	get_parent().playerDeath()

func goalReached():
	get_parent().playerGoal()

func setIdleState():
	change_state("idle")

func move_left():
	state.move_left()
func move_left_released():
	state.move_left_released()
func move_right():
	state.move_right()
func move_right_released():
	state.move_right_released()
func horizontal_stop():
	state.horizontal_stop()
	
func jump():
	state.jump()
func jump_released():
	state.jump_released()
func sprint_pressed():
	state.sprint_pressed()
func sprint_released():
	state.sprint_released()

func change_state(new_state_name):
	if is_instance_valid(state):
		state.queue_free()
	state = state_factory.get_state(new_state_name).new()
	state.setup(funcref(self, "change_state"), animation_player, sprite, self)
	state.name = "current_state"
	add_child(state)

func _physics_process(_delta):
	if Input.is_action_pressed("move_left"):
		move_left()
	if Input.is_action_pressed("move_right"):
		move_right()
	if not (Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right")): 
		horizontal_stop()
	if Input.is_action_pressed("jump"):
		jump()
	elif Input.is_action_just_released("jump"):
		jump_released()
	elif Input.is_action_pressed("sprint"):
		sprint_pressed()
	elif Input.is_action_just_released("sprint"):
		sprint_released()
