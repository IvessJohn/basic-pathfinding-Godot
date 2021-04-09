extends KinematicBody2D

export(int) var SPEED: int = 60
var velocity: Vector2 = Vector2.ZERO


func _physics_process(delta):
	var input_dir = get_input_direction()
	if input_dir != Vector2.ZERO:
		# PLAYER IS MOVING
		velocity = SPEED * input_dir
	else:
		# PLAYER IS IDLE
		velocity = Vector2.ZERO
	
	move()

func move():
	velocity = move_and_slide(velocity)

func get_input_direction() -> Vector2:
	var input_dir: Vector2 = Vector2.ZERO
	
	input_dir.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_dir.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input_dir = input_dir.normalized()
	
	return input_dir
