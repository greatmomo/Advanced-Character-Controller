extends CharacterBody2D
class_name Player

var speed = 80
var jump_impulse = 400
var gravity = 1200
var acceleration = 60
var friction = 20
var air_friction = 10

# double jump
@export var max_air_jumps := 0
var used_air_jumps = 0

# glide
@export var can_glide := false
@export var glide_fall_speed := 20.0

func get_input_direction() -> float:
	var direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	if direction < 0:
		$Sprite2D.flip_h = true
	if direction > 0:
		$Sprite2D.flip_h = false
	
	return direction

func _unhandled_key_input(event):
	if event.is_action_pressed("quit"):
		get_tree().quit()
