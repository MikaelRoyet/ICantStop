extends Node

onready var current_level = $Menu
onready var anim = $AnimationPlayer
onready var canvas = $CanvasLayer
onready var colorRect = $CanvasLayer/ColorRect

var next_level = null

func _ready():
	current_level.connect("level_changed", self, 'handle_level_changed')

#Executé au changement de scene et apelle l'animation de transition
func handle_level_changed(level_path: String):
	print("load : " + level_path)
	if ResourceLoader.exists(level_path):
		next_level = load(level_path).instance()
	else:
		next_level = load(GameManager.MENU_SCENE).instance()
		
	print("nextlevel : " + level_path)
	anim.play("fade_in")
	canvas.layer = 5
	colorRect.visible = true


#Executé à la fin d'une des animation de transition
func _on_AnimationPlayer_animation_finished(anim_name):
	match anim_name:
		"fade_in":
			print("fade in chargement")
			call_deferred("add_child", (next_level))
			current_level.queue_free()
			current_level = next_level
			current_level.connect("level_changed", self, 'handle_level_changed')
			next_level = null
			anim.play("fade_out")
			

		"fade_out":
			canvas.layer = -1
			colorRect.visible = false
