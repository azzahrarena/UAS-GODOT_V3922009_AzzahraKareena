extends CharacterBody2D

signal hit

enum State {
	walk

}

const WALK_SPEED = 100.0
@export var MAX_SPEED = 150
@export var target: Node2D

@onready var navigation_agent := $NavigationAgent2D as NavigationAgent2D


var _state := State.walk

@onready var gravity: int = ProjectSettings.get("physics/2d/default_gravity")
@onready var platform_detector := $platformDetector as RayCast2D
@onready var floor_detector_left := $leftDetector as RayCast2D
@onready var floor_detector_right := $rightDetector as RayCast2D
@onready var sprite := $Sprite2D as Sprite2D
@onready var animation_player := $AnimationPlayer as AnimationPlayer

func _physics_process(delta: float) -> void:
	if _state == State.walk and velocity.is_zero_approx():
		velocity.x = WALK_SPEED
	velocity.y += gravity * delta
	if not floor_detector_left.is_colliding():
		velocity.x = WALK_SPEED
	elif not floor_detector_right.is_colliding():
		velocity.x = -WALK_SPEED

	if is_on_wall():
		velocity.x = -velocity.x
		
	var direction = to_local(navigation_agent.get_next_path_position()).normalized()
	velocity = direction * MAX_SPEED

	move_and_slide()

	if velocity.x > 0.0:
		sprite.scale.x = 1.0
	elif velocity.x < 0.0:
		sprite.scale.x = -1.0

	var animation := get_new_animation()
	if animation != animation_player.current_animation:
		animation_player.play(animation)


# func destroy() -> void:
#	_state = State.DEAD
#	velocity = Vector2.ZERO
func create_path():
	navigation_agent.target_position = target.global_position

func get_new_animation() -> StringName:
	var animation_new: StringName
	if _state == State.walk:
		if velocity.x == 0:
			animation_new = &"idle"
		else:
			animation_new = &"walk"
	else:
		animation_new = &"destroy"
	return animation_new


func _on_timer_timeout():
	create_path()
