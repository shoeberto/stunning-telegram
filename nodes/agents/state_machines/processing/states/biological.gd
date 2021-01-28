class_name Biological
extends "res://nodes/state_machine/state.gd"

func enter():
    pass


# Clean up the state. Reinitialize values like a timer.
func exit():
    pass


func handle_input(_event):
    pass


func update(_delta):
    if check_bio():
        emit_signal('finished', 'performing_task')
    else:
        pass


func _on_animation_finished(_anim_name):
    pass


func check_bio() -> bool:
    return get_agent().get_current_awakeness() > 0 && get_agent().get_current_fullness() > 0
