extends Node

var loader : ResourceInteractiveLoader
var wait_frames
var time_max = 100 # msec
var current_scene
onready var levelchooser = preload("res://src/Levelchooser/Levelchooser.tscn")
onready var loadingscreen = preload("res://src/LoadingScreen/Loadingscreen.tscn")
onready var startscreen = preload("res://src/Startscreen/Startscreen.tscn")

var _options = {} 
const defaultOptions = {
	"masterVolume": 100,
	"musicVolume": 12,
	"sfxVolume": 100,
	"grayscale": true,
	"chromaticAberration":true,
	"chromaticAberrationAmount":11,
	"currentTrack":1
} 

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
	loadOptions()

func goto_levelchooser():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
	current_scene.queue_free() # Get rid of the old scene.
	get_node("/root").add_child(levelchooser.instance())

func goto_startscreen():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
	current_scene.queue_free() # Get rid of the old scene.
	get_node("/root").add_child(startscreen.instance())

func goto_scene(path): # Game requests to switch to this scene.
	print("goto_scene(path):" + path)
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
	loader = ResourceLoader.load_interactive(path)
	if loader == null: # Check for errors.
		#loader.show_error()
		return
	set_process(true)
	current_scene.queue_free() # Get rid of the old scene.
	# Start your "loading..." animation.
	get_node("/root").add_child(loadingscreen.instance())
	wait_frames = 1

func _process(_time):
	if loader == null:
		# no need to process anymore
		set_process(false)
		return

	# Wait for frames to let the "loading" animation show up.
	if wait_frames > 0:
		wait_frames -= 1
		return

	var t = OS.get_ticks_msec()
	# Use "time_max" to control for how long we block this thread.
	while OS.get_ticks_msec() < t + time_max:
		# Poll your loader.
		var err = loader.poll()

		if err == ERR_FILE_EOF: # Finished loading.
			var resource = loader.get_resource()
			loader = null
			set_new_scene(resource)
			break
		elif err == OK:
			update_progress()
		else: # Error during loading.
			print("Error loading scene")
			loader = null
			break

func update_progress():
	var progress = float(loader.get_stage()) / loader.get_stage_count()
	# Update progressbar
	var progressbar: LoadingscreenScript = get_node("../Loadingscreen")
	progressbar.set_progress(progress)

func set_new_scene(scene_resource):
	current_scene = scene_resource.instance()
	get_node("../Loadingscreen").queue_free()
	get_node("/root").add_child(current_scene)

#Zu Anfang des Spiels i guess
func load_savefile():
	pass

#Wenn Spiel beendet wird, evtl hier dann auch exitGame oder so einbauen
func save_savefile():
	pass

func get_level_time(levelname):
	
	return 0

func set_level_time(levelname, time):
	pass

func get_level_deaths(levelname):
	
	return 0

func set_level_deaths(levelname, deaths):
	pass
	
func set_masterVolume(value:int):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),linear2db(value/100.0))
	saveOption("masterVolume", value)
	
func set_musicVolume(value:int):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),linear2db(value/100.0))
	saveOption("musicVolume", value)
	
func set_sfxVolume(value:int):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"),linear2db(value/100.0))
	saveOption("sfxVolume", value)

func getOption(key):
	if _options.has(key):
		return _options[key]
	elif defaultOptions.has(key):
		_options[key] = defaultOptions[key]
		saveOption(key, defaultOptions[key])
	else:
		print("No Option with this key")
		return null

func saveOption(key, value):
	if defaultOptions.has(key):
		_options[key] = value
		var file = File.new()
		file.open("user://options.save", File.WRITE)
		file.store_string(to_json(_options))
	else:
		print("No Option with this key")

func loadOptions():
	var file = File.new()
	if(file.file_exists("user://options.save")):
		file.open("user://options.save", File.READ)
		_options = parse_json(file.get_as_text())
	else:
		file.open("user://options.save", File.WRITE)
		file.store_string(to_json(defaultOptions))
		_options = defaultOptions
	file.close()
	#return content
