extends PlayerState

#@export var _animation_player : NodePath
#@onready var animation_player:AnimationPlayer = get_node(_animation_player)

func enter(msg := {}) -> void:
	if msg.has("do_jump"):
		player.velocity.y = -player.jump_impulse
		#animation_player.play("Jump")
	elif msg.has("air_jump"):
		player.velocity.y = -player.jump_impulse
		#animation_player.play("Jump")
		player.used_air_jumps += 1
	else:
		player.coyote_timer = player.coyote_time_val

func physics_update(delta) -> void:
	if not is_zero_approx(player.get_input_direction()):
		player.velocity.x = lerp(player.velocity.x, player.get_input_direction() * player.speed, player.acceleration * delta)
	else:
		player.velocity.x = lerp(player.velocity.x, 0.0, player.air_friction * delta)
	
	player.velocity.y += player.gravity * delta
	
	# variable jump height if jump is released early
	if Input.is_action_just_released("jump") and player.velocity.y < 0:
		player.velocity.y = 0
	
	# decrement timers
	if player.jump_buffer_timer > 0.0:
		player.jump_buffer_timer -= delta
	if player.coyote_timer > 0.0:
		player.coyote_timer -= delta
	
	# air jump if available, or start jump buffer timer
	if Input.is_action_just_pressed("jump"):
		if player.coyote_timer > 0.0:
			state_machine.transition_to("Air", {do_jump = true})
		elif (player.used_air_jumps < player.max_air_jumps):
			state_machine.transition_to("Air", {air_jump = true})
		else:
			player.jump_buffer_timer = player.jump_buffer_time
	
	# glide if available
	if Input.is_action_pressed("jump") and (player.used_air_jumps == player.max_air_jumps) and player.can_glide:
		player.velocity.y = clampf(player.velocity.y, -999999.9, player.glide_fall_speed)
		if not is_zero_approx(player.get_input_direction()):
			player.velocity.x *= player.glide_speed_adjust
	
	if Input.is_action_just_pressed("dash") and player.can_dash:
		state_machine.transition_to("Dash")
	
	if player.is_on_wall_only() and player.can_wall_jump and player.velocity.y >= 0.0:
		player.used_air_jumps = 0
		state_machine.transition_to("Wall")
	
	player.sprite_2d.scale.y = remap(abs(player.velocity.y), 0, abs(player.jump_impulse), 0.75 * player.player_scale, 1.75 * player.player_scale)
	player.sprite_2d.scale.x = remap(abs(player.velocity.y), 0, abs(player.jump_impulse), 1.25 * player.player_scale, 0.75 * player.player_scale)
	
	player.move_and_slide()
	
	if player.is_on_floor():
		if player.jump_buffer_timer > 0.0:
			state_machine.transition_to("Air", {do_jump = true})
		
		player.used_air_jumps = 0
		player.sprite_2d.scale.y = remap(abs(player.previous_velocity.y), 0, abs(1700), 0.8 * player.player_scale, 0.5 * player.player_scale)
		player.sprite_2d.scale.x = remap(abs(player.previous_velocity.x), 0, abs(1700), 1.2 * player.player_scale, 2.0 * player.player_scale)
		if is_zero_approx(player.get_input_direction()):
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Run")
	
	player.previous_velocity = player.velocity
