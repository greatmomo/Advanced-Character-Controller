extends PlayerState

@export var _animation_player : NodePath
@onready var animation_player:AnimationPlayer = get_node(_animation_player)

func enter(_msg := {}) -> void:
	animation_player.play("Idle")

func _physics_process(delta) -> void:
	if not player.is_on_floor():
		state_machine.transition_to("Air")
		return
	
	player.velocity.x = lerp(player.velocity.x, 0.0, player.friction * delta)
	player.move_and_slide()
	
	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Air", {do_jump = true})
	elif not is_zero_approx(player.get_input_direction()):
		state_machine.transition_to("Run")
