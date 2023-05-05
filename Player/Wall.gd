extends PlayerState

#@export var _animation_player : NodePath
#@onready var animation_player:AnimationPlayer = get_node(_animation_player)

func enter(msg := {}) -> void:
	#animation_player.play("Wall")
	player.velocity.y = 0.0
	pass

func physics_update(delta) -> void:
	if not is_zero_approx(player.get_input_direction()):
		player.velocity.x = lerp(player.velocity.x, player.get_input_direction() * player.speed, player.acceleration * delta)
	else:
		player.velocity.x = lerp(player.velocity.x, 0.0, player.air_friction * delta)
	
	player.velocity.y = player.gravity * delta * player.wall_gravity_ratio
	
	player.sprite_2d.scale.y = lerp(player.sprite_2d.scale.y, 1.0 * player.player_scale, 1 - pow(0.1 * player.player_scale, delta))
	player.sprite_2d.scale.x = lerp(player.sprite_2d.scale.x, 1.0 * player.player_scale, 1 - pow(0.1 * player.player_scale, delta))
	
	# jump off wall
	if Input.is_action_just_pressed("jump"):
		player.velocity.x -= player.orientation * player.wall_jump_distance
		state_machine.transition_to("Air", {do_jump = true})
	
	# dash off wall
	if Input.is_action_just_pressed("dash"):
		player.orientation *= -1
		state_machine.transition_to("Dash")
	
	player.move_and_slide()
	
	if not player.is_on_wall():
		state_machine.transition_to("Air")
	
	player.previous_velocity = player.velocity
