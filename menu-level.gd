extends Node2D

var audio_player : AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready():
	audio_player = $AudioStreamPlayer2D # Pastikan ini mengacu pada AudioStreamPlayer Anda

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func play_music():
	# Load the audio stream (musik) yang ingin Anda putar
	var music = load("res://Asset/Horror SFX Free/Stingers and Spooky Triggers/Piano_stinger_dissonent.wav")
		# Tetapkan audio stream ke AudioStreamPlayer
	audio_player.stream = music
	
	# Memulai pemutaran musik
	audio_player.play()


func _on_click_tree_exiting():
	play_music()



func _on_easy_pressed():
	get_tree().change_scene_to_file("res://main-easy.tscn")


func _on_medium_pressed():
	get_tree().change_scene_to_file("res://main.tscn")


func _on_hard_pressed():
	get_tree().change_scene_to_file("res://main-hard.tscn")
