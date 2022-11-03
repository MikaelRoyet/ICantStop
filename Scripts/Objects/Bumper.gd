extends KinematicBody2D

const SPEED = GameManager.SPEED

onready var particleBounce = load("res://Scenes/Particles/ParticleBounce.tscn")

var velocityBumper = Vector2(0,0)
var lastMovement
var bumpingPlayer = false
var isMovingBumper = false

export (Vector2) var directionStart = Vector2(0,0)

func _ready():
	lastMovement = Vector2(0,0)
	if directionStart != Vector2(0,0):
		velocityBumper = directionStart * SPEED
		lastMovement = directionStart * SPEED

func _physics_process(delta):
	velocityBumper = move_and_slide(velocityBumper)
	
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray(position, position + lastMovement, [self])
	
	if result:
		if(result.collider.is_in_group("Player")):
			bumpingPlayer = true
		else:
			bumpingPlayer = false
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision:
			if collision.collider.is_in_group("Bumper"):
				if collision.collider.has_method("move"):
					collision.collider.move(lastMovement)
					bounce()



func move(movement):
	velocityBumper = movement
	lastMovement = movement
	GameManager.createParticle(particleBounce, position, rotation_degrees)


func bounce():
	move(lastMovement * -1)

func moveToPoint(point):
	position = point
