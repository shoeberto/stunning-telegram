class_name Biological
extends "res://nodes/state_machine/state.gd"

func enter():
    print('state entered')


# Clean up the state. Reinitialize values like a timer.
func exit():
	pass


func handle_input(_event):
	pass


func update(_delta):
    pass


func _on_animation_finished(_anim_name):
	pass
