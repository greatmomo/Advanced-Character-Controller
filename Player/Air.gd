extends PlayerState


@export var _animation_player : NodePath
@onready var animation_player:AnimationPlayer = get_node(_animation_player)

func enter(msg := {}) -> void:
	if msg.has("do_jump"):
		player.velocity.y = -player.jump_impulse
		animation_player.play("Jump")

func _physics_process(delta) -> void:
	if not is_zero_approx(player.get_input_direction()):
		player.velocity.x = lerp(player.velocity.x, player.get_input_direction() * player.speed, player.acceleration * delta)
	else:
		player.velocity.x = lerp(player.velocity.x, 0.0, player.air_friction * delta)
	
	player.velocity.y += player.gravity * delta
	player.move_and_slide()
	
	if player.is_on_floor():
		if is_zero_approx(player.get_input_direction()):
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Run")
