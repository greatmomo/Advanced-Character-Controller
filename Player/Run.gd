extends PlayerState

#@export var _animation_player : NodePath
#@onready var animation_player:AnimationPlayer = get_node(_animation_player)

func enter(_msg := {}) -> void:
	#animation_player.play("Run")
	pass

func physics_update(delta) -> void:
	player.sprite_2d.scale.y = lerp(player.sprite_2d.scale.y, 1.0 * player.player_scale, 1 - pow(0.1 * player.player_scale, delta))
	player.sprite_2d.scale.x = lerp(player.sprite_2d.scale.x, 1.0 * player.player_scale, 1 - pow(0.1 * player.player_scale, delta))
	
	if not is_zero_approx(player.get_input_direction()):
		player.velocity.x = lerp(player.velocity.x, player.get_input_direction() * player.speed, player.acceleration * delta)
	
	player.velocity.y += player.gravity * delta
	player.move_and_slide()
	
	if not player.is_on_floor():
		state_machine.transition_to("Air")
	elif Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Air", {do_jump = true})
	elif Input.is_action_just_pressed("dash") and player.can_dash:
		state_machine.transition_to("Dash")
	elif is_zero_approx(player.get_input_direction()):
		state_machine.transition_to("Idle")
