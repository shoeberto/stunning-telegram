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
    var parent = get_parent()
    var t = parent.get_node('PerformingTask')

    var current_task = t._task_queue.get_current_task()
    var preempt = current_task == null
        
    if !preempt:
        preempt = current_task.name != 'Sleep'        

    if !check_bio() && preempt:
        t._task_queue._preempt_task(t._task_queue.get_node('Sleep'))

    emit_signal('finished', 'performing_task')


func _on_animation_finished(_anim_name):
    pass


func check_bio() -> bool:
    var awakeness = get_agent().get_current_awakeness() 
    var fullness = get_agent().get_current_fullness()
    if get_agent().get_current_awakeness() > 0 && get_agent().get_current_fullness() > 0:
        return true
    else:
        return false
