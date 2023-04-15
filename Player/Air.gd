extends PlayerState


@export var _animation_player : NodePath
@onready var animation_player:AnimationPlayer = get_node(_animation_player)

func enter(msg := {}) -> void:
	if msg.has("do_jump"):
		player.velocity.y = -player.jump_impulse
		animation_player.play("Jump")
	if msg.has("air_jump"):
		player.velocity.y = -player.jump_impulse
		animation_player.play("Jump")
		player.used_air_jumps += 1

func physics_update(delta) -> void:
	if not is_zero_approx(player.get_input_direction()):
		player.velocity.x = lerp(player.velocity.x, player.get_input_direction() * player.speed, player.acceleration * delta)
	else:
		player.velocity.x = lerp(player.velocity.x, 0.0, player.air_friction * delta)
	
	player.velocity.y += player.gravity * delta
	
	# variable jump height if jump is released early
	if Input.is_action_just_released("jump") and player.velocity.y < 0:
		player.velocity.y = 0
	
	# air jump if available
	if Input.is_action_just_pressed("jump") and (player.used_air_jumps < player.max_air_jumps):
		state_machine.transition_to("Air", {air_jump = true})
	
	# glide if available
	if Input.is_action_pressed("jump") and (player.used_air_jumps == player.max_air_jumps) and player.can_glide:
		player.velocity.y = clampf(player.velocity.y, -999999.9, player.glide_fall_speed)
		player.velocity.x *= 1.5
	
	player.move_and_slide()
	
	if player.is_on_floor():
		player.used_air_jumps = 0
		if is_zero_approx(player.get_input_direction()):
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Run")
