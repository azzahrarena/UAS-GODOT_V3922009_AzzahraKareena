extends CharacterBody2D

@export var speed: int = 60
@export var ACCELERATION = 500
@export var MAX_SPEED = 200
@export var FRICTION  = 500
@onready var anim = get_node("AnimatedSprite2D")
@onready var anim2 = get_node("AnimatedSprite2D2")
var walkSound = AudioStreamPlayer.new();
var isGameOver = false
var enemy = null
@onready var main =  $'..'
@onready var score =  $'../Score'
@onready var MainMenu =  $"../CanvasLayer/MainMenu"

func _ready():
	anim.play("idle")
	anim2.play("idle")
	
func handleInput():
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if moveDirection:
		velocity = moveDirection * MAX_SPEED
		if Input.is_action_just_pressed("ui_right"):
			$AnimatedSprite2D.play("right")
			$AnimatedSprite2D2.play("right")
			self.add_child(walkSound);
			walkSound.stream = load("res://Asset/Horror SFX Free/Character/Footsteps_walking.wav")
			walkSound.play()
		elif Input.is_action_just_pressed("ui_left"):
			$AnimatedSprite2D.play("left")
			$AnimatedSprite2D2.play("left")
			self.add_child(walkSound);
			walkSound.stream = load("res://Asset/Horror SFX Free/Character/Footsteps_walking.wav")
			walkSound.play()
		elif Input.is_action_just_pressed("ui_up"):
			$AnimatedSprite2D.play("up")
			$AnimatedSprite2D2.play("up")
			self.add_child(walkSound);
			walkSound.stream = load("res://Asset/Horror SFX Free/Character/Footsteps_walking.wav")
			walkSound.play()
		elif Input.is_action_just_pressed("ui_down"):
			$AnimatedSprite2D.play("down")
			$AnimatedSprite2D2.play("down")
			self.add_child(walkSound);
			walkSound.stream = load("res://Asset/Horror SFX Free/Character/Footsteps_walking.wav")
			walkSound.play()
		main.addScore()
	else:
		velocity = Vector2(0, 0)
		anim.play("idle")
		anim2.play("idle")
			
func _physics_process(delta):
	handleInput()
	move_and_slide()
	
	if enemy and !isGameOver and enemy.is_colliding:
		game_over()

func game_over():
	isGameOver = true
	get_tree().change_scene_to_file("res://gameover.tscn")



func _on_audio_stream_player_tree_entered():
	pass # Replace with function body.


func _on_area_2d_area_entered(area):
	get_tree().change_scene_to_file("res://gameover.tscn")
