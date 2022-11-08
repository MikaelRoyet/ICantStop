extends KinematicBody2D

const SPEED = GameManager.SPEED

onready var soundEffectPlayer : = $SoundEffectPlayer

onready var particleBounce = load("res://Scenes/Particles/ParticleBounce.tscn")

var velocityBumper = Vector2(0,0)
var lastMovement
var bumpingPlayer = false
var isMovingBumper = false
var speedModifier

export (bool) var isMovable = true
export (Vector2) var directionStart = Vector2(0,0)

func _ready():
	lastMovement = Vector2(0,0)
	speedModifier = 1
	if directionStart != Vector2(0,0):
		velocityBumper = directionStart * SPEED
		lastMovement = directionStart * SPEED

func _physics_process(delta):
	velocityBumper = move_and_slide(velocityBumper)
	
	var space_state = get_world_2d().direct_space_state
	var vectorSwap = Vector2(lastMovement.y, lastMovement.x).normalized()
	var result1 = space_state.intersect_ray(global_position + vectorSwap * 13, (global_position + vectorSwap * 13) + lastMovement * GameManager.SPEED, [self])
	var result2 = space_state.intersect_ray(global_position + vectorSwap * -13, (global_position + vectorSwap * -13) + lastMovement * GameManager.SPEED, [self])
	
	
	if result1 && result2:
		if(result1.collider.is_in_group("Player") || result2.collider.is_in_group("Player")):
			print("ON DETEKT D TRUK")
			if(!bumpingPlayer):
				GameManager.wait(0.25, "setBumpingToFalse" ,self)
				bumpingPlayer = true
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision:
			if collision.collider.is_in_group("Bumper"):
				if collision.collider.has_method("move"):
					collision.collider.move(lastMovement)
					bounce()
				AudioManager.playSound(AudioManager.soundEffectBump)



func move(movement):
	
	if isMovable:
		velocityBumper = movement * speedModifier
		lastMovement = movement
	GameManager.createParticle(particleBounce, position, rotation_degrees)


func bounce():
	move(lastMovement * -1)

func moveToPoint(point):
	position = point

func modifySpeedModifier(value):
	speedModifier = value
	move(lastMovement)

func setBumpingToFalse():
	bumpingPlayer = false
