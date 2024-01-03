extends Node2D

@onready var mainMenu = $CanvasLayer/MainMenu
@onready var skor = $Score
@onready var prevScore = $previousScore

var nilai = 0
# Called when the node enters the scene tree for the first time.
var audio_player = AudioStreamPlayer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	load_game()
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

func addScore():
	nilai+=1
	skor.text = "Your Score: " + str(nilai)
	
func game_over():
	save_game()
	get_tree().change_scene_to_file("res://gameover.tscn")
	

func save():
	var save_dict = {
		"score": nilai,
		"username": "yoru",
		"position": Vector3(0, 0, 0),
		"enemy": "Dead",
		"level": 2
	}
	return save_dict
	
func save_game():
	var save_game = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	
	var json_string = JSON.stringify(save())
	
	save_game.store_line(json_string)
	
func load_game():
	if not FileAccess.file_exists("user://savegame.save"):
		return
	var save_game = FileAccess.open("user://savegame.save", FileAccess.READ)
	
	while save_game.get_position() < save_game.get_length():
		var json_string = save_game.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		var node_data = json.get_data()
		
		prevScore.show()
		prevScore.text = "Previous Score: " + str(node_data["score"])
		
