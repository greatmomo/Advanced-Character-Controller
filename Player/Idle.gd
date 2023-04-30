extends PlayerState

#@export var _animation_player : NodePath
#@onready var animation_player:AnimationPlayer = get_node(_animation_player)

func enter(_msg := {}) -> void:
	#animation_player.play("Idle")
	pass

func physics_update(delta) -> void:
	if not player.is_on_floor():
		state_machine.transition_to("Air")
		return
	
	player.sprite_2d.scale.y = lerp(player.sprite_2d.scale.y, 0.1, 1 - pow(0.01, delta))
	player.sprite_2d.scale.x = lerp(player.sprite_2d.scale.x, 0.1, 1 - pow(0.01, delta))
	
	player.velocity.x = lerp(player.velocity.x, 0.0, player.friction * delta)
	player.move_and_slide()
	
	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Air", {do_jump = true})
	elif Input.is_action_just_pressed("dash") and player.can_dash:
		state_machine.transition_to("Dash")
	elif not is_zero_approx(player.get_input_direction()):
		state_machine.transition_to("Run")
