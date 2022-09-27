extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var listPoints = []
export var isBoucle:bool
var nextPoint
var vector

# Called when the node enters the scene tree for the first time.
func _ready():
	nextPoint = 1
	movingToPoint()

func _process(delta):

	
	if position.distance_to(get_node(listPoints[nextPoint]).position) < 1:
		if(listPoints.size() > nextPoint + 1):
			nextPoint = nextPoint + 1
		else:
			if isBoucle:
				nextPoint = 0
			else:
				pass

	vector = (get_node(listPoints[nextPoint]).position - position).normalized()
	move_and_slide(vector * GameManager.SPEED * delta * 15)

func movingToPoint():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass