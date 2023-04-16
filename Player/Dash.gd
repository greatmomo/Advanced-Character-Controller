extends PlayerState

@export var _animation_player : NodePath
@onready var animation_player:AnimationPlayer = get_node(_animation_player)

var dash_timer : float = 0.0

func enter(msg := {}) -> void:
	dash_timer = 0.0

func physics_update(delta) -> void:
	if player.dash_time > dash_timer:
		player.velocity.x = player.get_orientation() * player.dash_velocity
		player.velocity.y = 0.0
	else:
		state_machine.transition_to("Air")
	
	dash_timer += delta
	
	player.move_and_slide()
