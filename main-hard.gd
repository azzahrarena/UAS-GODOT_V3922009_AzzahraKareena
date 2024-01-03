extends Node2D


# Called when the node enters the scene tree for the first time.
var audio_player = AudioStreamPlayer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	audio_player = $AudioStreamPlayer2D 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func play_music():
	self.add_child(audio_player);

	audio_player.stream = load("res://Asset/Suara Kuntilanak.mp3")
	
	audio_player.play()

func _on_audio_stream_player_2d_tree_entered():
	play_music()


func _on_tree_entered():
	play_music()
