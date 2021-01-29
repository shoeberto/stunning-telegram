extends "res://nodes/agents/state_machines/task_queue/states/task_state.gd"


# Initialize the state. E.g. change the animation.
func enter():
    find_occupyable_target('food')


# Clean up the state. Reinitialize values like a timer.
func exit():
    .exit()
    get_agent().update_state_label('')
    if get_target() && get_target().get_occupant() == get_agent():
        get_target().leave(get_agent())

    set_target(null)
    stop_animation()

func handle_input(_event):
    pass


func update(_delta):
    if get_target() == null:
        get_agent().update_state_label('searching for bed')
        find_occupyable_target('food')
    elif is_within_activation_range(get_target().get_global_position()):
        if get_target().get_occupant() != get_agent():
            if get_target().is_occupied():
                set_target(null)
                find_occupyable_target('food')
            else:
                get_target().occupy(get_agent())
        else:
            get_agent().update_state_label('sleeping')
            get_agent().sleep(_delta)
            stop_animation()
    else:
        get_agent().update_state_label('going to bed')
        move(_delta, get_target().get_global_position())

func stop_animation():
    get_agent().get_animation_player().stop()

func _on_animation_finished(_anim_name):
    pass

func is_task_done() -> bool:
    return get_agent().get_current_awakeness() > (get_agent().max_awakeness * 0.75)
