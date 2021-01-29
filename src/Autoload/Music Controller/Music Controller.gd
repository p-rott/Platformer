extends Control

# Load the music player node
onready var _player:AudioStreamPlayer = $AudioStreamPlayer
export var musicPath:String
var songs:Array
func _ready():
	var dir:Directory = Directory.new() 
	if dir.open("res://assets/audio/music/") == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir() and not ".import" in file_name:
				songs.append(load(musicPath+file_name))
			file_name = dir.get_next()
	else:
		print_debug("An error occurred when trying to access Music")
	if(Global.getOption("currentTrack")<songs.size()):
		play(songs[Global.getOption("currentTrack")])
		
# Calling this function will load the given track, and play it
func play(track):
	_player.stream = track
	_player.play()
	_player.stream_paused = false

# Calling this function will stop the music
func stop():
	_player.stop()
	
#Calling this function will pause/unpause music
func toggle_pause():
	_player.stream_paused = not _player.stream_paused
func pause(pausing : bool):
	_player.stream_paused = pausing
func nextTrack():
	
	var currentTrack = Global.getOption("currentTrack")
	currentTrack += 1
	if currentTrack >= songs.size():
		currentTrack = 0
	play(songs[currentTrack])
	Global.saveOption("currentTrack", currentTrack)

func prevTrack():
	var currentTrack = Global.getOption("currentTrack")
	currentTrack -= 1
	if currentTrack < 0:
		currentTrack = songs.size() - 1
	Global.saveOption("currentTrack", currentTrack)



