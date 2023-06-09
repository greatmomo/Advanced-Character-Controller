extends CharacterBody2D
class_name Player

@export var player_scale := 0.1

@export_category("movement")
@export var speed := 120 # speed 20 and jump 200 for mud effect
@export var jump_impulse := 400
@export var gravity := 1200
@export var acceleration := 20 # accel and friction = 2, speed 150 for ice effect
@export var friction := 13
@export var air_friction := 4
@export var max_fall_speed := 500

@export_category("double_jump")
@export var max_air_jumps := 0
var used_air_jumps = 0

@export_category("jump_buffer")
@export var jump_buffer_time := 0.1
var jump_buffer_timer := 0.0

@export_category("coyote_time")
@export var coyote_time_val := 0.1
var coyote_timer := 0.0

@export_category("wall_jump")
@export var can_wall_jump := false
@export var wall_gravity_ratio := 2.0
@export var wall_jump_distance := 150.0

@export_category("dash")
@export var can_dash := false
@export var dash_time := 0.1
@export var dash_velocity := 350

@export_category("glide")
@export var can_glide := false
@export var glide_fall_speed := 25.0
@export var glide_speed_adjust := 1.3

var orientation := 1.0
var previous_velocity := Vector2.ZERO

@onready var sprite_2d = $Sprite2D

func get_input_direction() -> float:
	var direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	if direction < 0:
		$Sprite2D.flip_h = true
	if direction > 0:
		$Sprite2D.flip_h = false
	
	if abs(direction) > 0:
		orientation = direction
	
	return direction

func _unhandled_key_input(event):
	if event.is_action_pressed("quit"):
		get_tree().quit()

func get_orientation() -> float:
	return orientation
