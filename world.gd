extends Node

@onready var player = $Player

@onready var ui_container = $UI/UIContainer
@onready var info_text_container = $UI/InfoTextContainer

@onready var wall_jump = $UI/UIContainer/PanelContainer/VBoxContainer/HBoxContainer/HBoxContainer/WallJump
@onready var wall_gravity = $UI/UIContainer/PanelContainer/VBoxContainer/HBoxContainer/HBoxContainer2/WallGravity
@onready var wall_jump_distance = $UI/UIContainer/PanelContainer/VBoxContainer/HBoxContainer/HBoxContainer3/WallJumpDistance

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
