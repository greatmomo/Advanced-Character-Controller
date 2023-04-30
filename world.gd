extends Node

@onready var player = $Player

@onready var ui_container = $UI/UIContainer
@onready var info_text_container = $UI/InfoTextContainer

@onready var speed = $"UI/UIContainer/PanelContainer/VBoxContainer/Basic Movement/HBoxContainer/Speed"
@onready var acceleration = $"UI/UIContainer/PanelContainer/VBoxContainer/Basic Movement/HBoxContainer3/Acceleration"
@onready var jump_strength = $"UI/UIContainer/PanelContainer/VBoxContainer/Basic Movement/HBoxContainer2/JumpStrength"
@onready var gravity = $"UI/UIContainer/PanelContainer/VBoxContainer/Basic Movement/HBoxContainer4/Gravity"
@onready var friction = $"UI/UIContainer/PanelContainer/VBoxContainer/Movement + Air Jumps/HBoxContainer/Friction"
@onready var air_friction = $"UI/UIContainer/PanelContainer/VBoxContainer/Movement + Air Jumps/HBoxContainer3/AirFriction"
@onready var max_air_jumps = $"UI/UIContainer/PanelContainer/VBoxContainer/Movement + Air Jumps/HBoxContainer2/MaxAirJumps"
@onready var wall_jump = $"UI/UIContainer/PanelContainer/VBoxContainer/Wall Jump/HBoxContainer/WallJump"
@onready var wall_gravity = $"UI/UIContainer/PanelContainer/VBoxContainer/Wall Jump/HBoxContainer2/WallGravity"
@onready var wall_jump_distance = $"UI/UIContainer/PanelContainer/VBoxContainer/Wall Jump/HBoxContainer3/WallJumpDistance"
@onready var dash = $UI/UIContainer/PanelContainer/VBoxContainer/Dash/HBoxContainer/Dash
@onready var dash_time = $UI/UIContainer/PanelContainer/VBoxContainer/Dash/HBoxContainer2/DashTime
@onready var dash_velocity = $UI/UIContainer/PanelContainer/VBoxContainer/Dash/HBoxContainer3/DashVelocity
@onready var coyote_time = $"UI/UIContainer/PanelContainer/VBoxContainer/Advanced Jumps/HBoxContainer/CoyoteTime"
@onready var jump_buffer_time = $"UI/UIContainer/PanelContainer/VBoxContainer/Advanced Jumps/HBoxContainer3/JumpBufferTime"
@onready var glide = $UI/UIContainer/PanelContainer/VBoxContainer/Glide/HBoxContainer/Glide
@onready var glide_fall_speed = $UI/UIContainer/PanelContainer/VBoxContainer/Glide/HBoxContainer2/GlideFallSpeed
@onready var glide_speed_adjust = $UI/UIContainer/PanelContainer/VBoxContainer/Glide/HBoxContainer3/GlideSpeedAdjust

func _unhandled_key_input(event):
	if event.is_action_pressed("show_ui"):
		ui_container.show()
		info_text_container.hide()
	
	if event.is_action_released("show_ui"):
		ui_container.hide()
		info_text_container.show()

func _on_wall_jump_pressed():
	if wall_jump.is_pressed():
		player.can_wall_jump = true
	else:
		player.can_wall_jump = false

func _on_wall_gravity_value_changed(value):
	player.wall_gravity_ratio = wall_gravity.get_value()

func _on_wall_jump_distance_value_changed(value):
	player.wall_jump_distance = wall_jump_distance.get_value()

func _on_speed_value_changed(value):
	player.speed = speed.get_value()

func _on_acceleration_value_changed(value):
	player.acceleration = acceleration.get_value()

func _on_jump_strength_value_changed(value):
	player.jump_impulse = jump_strength.get_value()

func _on_gravity_value_changed(value):
	player.gravity = gravity.get_value()

func _on_friction_value_changed(value):
	player.friction = friction.get_value()

func _on_air_friction_value_changed(value):
	player.air_friction = air_friction.get_value()

func _on_max_air_jumps_value_changed(value):
	player.max_air_jumps = max_air_jumps.get_value()

func _on_dash_pressed():
	if dash.is_pressed():
		player.can_dash = true
	else:
		player.can_dash = false

func _on_dash_time_value_changed(value):
	player.dash_time = dash_time.get_value()

func _on_dash_velocity_value_changed(value):
	player.dash_velocity = dash_velocity.get_value()

func _on_coyote_time_value_changed(value):
	player.coyote_time_val = coyote_time.get_value()

func _on_jump_buffer_time_value_changed(value):
	player.jump_buffer_time = jump_buffer_time.get_value()

func _on_glide_pressed():
	if glide.is_pressed():
		player.can_glide = true
	else:
		player.can_glide = false

func _on_glide_fall_speed_value_changed(value):
	player.glide_fall_speed = glide_fall_speed.get_value()

func _on_glide_speed_adjust_value_changed(value):
	player.glide_speed_adjust = glide_speed_adjust.get_value()
