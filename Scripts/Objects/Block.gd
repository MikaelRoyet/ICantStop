extends StaticBody2D


onready var sprite = $Sprite
onready var collision = $CollisionShape2D

var spriteBlock = load("res://Sprites/Objects/Block.png")
var spriteBlockEmpty = load("res://Sprites/Objects/BlockEmpty.png")

export (Color) var color
export var isVisible = true


# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.modulate = color
	if !isVisible:
		setVisibility()

func setVisibility():
	collision.set_deferred("disabled", !isVisible)
	if isVisible:
		sprite.texture = spriteBlock
	else:
		sprite.texture = spriteBlockEmpty

func changeVisibility():
	isVisible = !isVisible
	setVisibility()
