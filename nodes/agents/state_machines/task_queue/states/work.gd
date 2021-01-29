extends "res://nodes/agents/state_machines/task_queue/states/task_state.gd"


# Initialize the state. E.g. change the animation.
func enter():
    find_consumable_target('work_items')


# Clean up the state. Reinitialize values like a timer.
func exit():
    .exit()
    get_agent().update_state_label('')
    set_target(null)
    stop_animation()


func handle_input(_event):
    pass


func update(_delta):
    if get_target() == null:
        get_agent().update_state_label('finding harvest')
        find_consumable_target('work_items')
        get_agent().update_state_label('')
        return

    if is_within_activation_range(get_target().get_global_position()):
        if get_target().is_empty():
            set_target(null)
        else:
            stop_animation()
            get_agent().update_state_label('harvesting')
            get_agent().harvest(_delta, get_target())
    else:
        get_agent().update_state_label('moving to harvest')
        move(_delta, get_target().get_global_position())

func stop_animation():
    get_agent().get_animation_player().stop()

func _on_animation_finished(_anim_name):
    pass


#func is_task_done():
#    return get_agent().get_current_harvest() == get_agent().max_harvest
