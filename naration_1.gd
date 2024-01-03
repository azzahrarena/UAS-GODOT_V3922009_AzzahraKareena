extends Node2D

var audio_player : AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready():
	audio_player = $AudioStreamPlayer2D2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_pressed():
	get_tree().change_scene_to_file("res://menu-level.tscn")
	
func play_music():
	# Load the audio stream (musik) yang ingin Anda putar
	var music = load("res://Asset/Horror SFX Free/Monsters & Ghosts/Laugh_spooky_4.wav")
		# Tetapkan audio stream ke AudioStreamPlayer
	audio_player.stream = music
	
	# Memulai pemutaran musik
	audio_player.play()


func _on_tree_exiting():
	play_music()
