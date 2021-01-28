
class_name ProcessingStateMachine
extends "res://nodes/state_machine/state_machine.gd"

onready var biological = get_node('./Biological')
onready var performing_task = get_node('./PerformingTask')


func _ready():
    states_map = {
        "biological": biological,
        "performing_task": performing_task
    }


# func _change_state(state_name):
# 	# The base state_machine interface this node extends does most of the work.
# 	# if not _active:
# 	# 	return
        
# 	states_stack.push_front(states_map[state_name])

# 	# comment this out for now
# 	# if state_name in ["stagger", "jump", "attack"]:
# 	#     states_stack.push_front(states_map[state_name])
# 	# if state_name == "jump" and current_state == move:
# 	#     jump.initialize(move.speed, move.velocity)

    # ._change_state(state_name)
    

func _physics_process(delta):
    ._physics_process(delta)
    get_agent().decay()


func _unhandled_input(event):
    # Here we only handle input that can interrupt states, attacking in this case,
    # otherwise we let the state node handle it.
    # if event.is_action_pressed("attack"):
    #     if current_state in [attack, stagger]:
    #         return
    #     _change_state("attack")
    #     return
    current_state.handle_input(event)
