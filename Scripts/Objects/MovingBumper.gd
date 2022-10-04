extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var listPoints = []
export var isBoucle:bool
export var startingPoint = 1
var nextPoint
var vector
var lastMovement = Vector2(0,0)
var bumpingPlayer = true
var velocity = Vector2(0,0)
var isMovingBumper = true
var isSaw = false

var colorPoint = load("res://Scenes/Objects/ColorPoint.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	nextPoint = startingPoint
	movingToPoint()
	bumpingPlayer = false


func _physics_process(delta):
	update()
	var space_state = get_world_2d().direct_space_state
	var vectorSwap = Vector2(lastMovement.y, lastMovement.x)
	var result1 = space_state.intersect_ray(global_position + vectorSwap * 13, (global_position + vectorSwap * 13) + lastMovement * GameManager.SPEED, [self])
	var result2 = space_state.intersect_ray(global_position + vectorSwap * -13, (global_position + vectorSwap * -13) + lastMovement * GameManager.SPEED, [self])
	
	if result1 && result2:
		if(result1.collider.is_in_group("Player") || result2.collider.is_in_group("Player")):

			print("true", result1.collider.global_position)

			if(!bumpingPlayer):
				GameManager.wait(0.25, "setBumpingToFalse" ,self)
				bumpingPlayer = true

			
func _process(delta):
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision:
			if collision.collider.is_in_group("Bumper"):
				if collision.collider.has_method("move"):
					collision.collider.move(collision.collider.lastMovement * -1)
	
	if position.distance_to(get_node(listPoints[nextPoint]).position) < 3:

		if(listPoints.size() > nextPoint + 1):
			nextPoint = nextPoint + 1
		else:
			if isBoucle:
				nextPoint = 0
			else:
				pass

	vector = (get_node(listPoints[nextPoint]).position - position).normalized()
	lastMovement = vector
	velocity = move_and_slide(vector * GameManager.SPEED * delta * 30)

#func _draw():
#	var drawPoint = 0
#	for point in listPoints:
#		if(listPoints.size() > drawPoint + 1):
#			draw_line(get_node(point).global_position, get_node(listPoints[drawPoint + 1]).global_position, Color(1,1,1), 3)
#			drawPoint += 1
#		else:
#			draw_line(get_node(point).global_position, get_node(listPoints[0]).global_position , Color(1,1,1), 3)

func movingToPoint():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func move(movement):
	pass

func setBumpingToFalse():
	bumpingPlayer = false



