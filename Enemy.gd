extends KinematicBody2D

export(int) var SPEED: int = 40
var velocity: Vector2 = Vector2.ZERO


func _physics_process(delta):
	move()

func move():
	velocity = move_and_slide(velocity)
