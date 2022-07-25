extends KinematicBody2D

const SPEED = 100
var velocityPlayer = Vector2(0,0)
var idle = true


func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	velocityPlayer = move_and_slide(velocityPlayer)
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision:
			if collision.collider is TileMap:
				death()


func _on_SwipeDetector_swiped(direction):
	
	#UP
	if direction.x == 0 and direction.y == -1:
		velocityPlayer = Vector2(0, SPEED)
	
	#DOWN
	if direction.x == 0 and direction.y == 1:
		velocityPlayer = Vector2(0, -SPEED)
		
	#LEFT
	if direction.x == -1 and direction.y == 0:
		velocityPlayer = Vector2(SPEED, 0)
		
	#RIGHT
	if direction.x == 1 and direction.y == 0:
		velocityPlayer = Vector2(-SPEED, 0)
	
func death():
	print("DEADGE")
	

