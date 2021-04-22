extends KinematicBody2D

export(int) var SPEED: int = 40
var velocity: Vector2 = Vector2.ZERO

var path: Array = []	# Contains destination positions
var levelNavigation: Navigation2D = null
var player = null
var player_spotted: bool = false

onready var line2d = $Line2D
onready var los = $LineOfSight


func _ready():
	yield(get_tree(), "idle_frame")
	var tree = get_tree()
	if tree.has_group("LevelNavigation"):
		levelNavigation = tree.get_nodes_in_group("LevelNavigation")[0]
	if tree.has_group("Player"):
		player = tree.get_nodes_in_group("Player")[0]

func _physics_process(delta):
	line2d.global_position = Vector2.ZERO
	if player:
		los.look_at(player.global_position)
		check_player_in_detection()
		if player_spotted:
			generate_path()
			navigate()
	move()

func check_player_in_detection() -> bool:
	var collider = los.get_collider()
	if collider and collider.is_in_group("Player"):
		player_spotted = true
		print("raycast collided")	# Debug purposes
		return true
	return false

func navigate():	# Define the next position to go to
	if path.size() > 0:
		velocity = global_position.direction_to(path[1]) * SPEED
		
		# If reached the destination, remove this point from path array
		if global_position == path[0]:
			path.pop_front()

func generate_path():	# It's obvious
	if levelNavigation != null and player != null:
		path = levelNavigation.get_simple_path(global_position, player.global_position, false)
		line2d.points = path

func move():
	velocity = move_and_slide(velocity)
