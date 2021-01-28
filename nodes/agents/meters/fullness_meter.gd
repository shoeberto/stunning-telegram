extends "res://nodes/agents/meters/meter.gd"


func _physics_process(delta):
    set_value(calculate_progress(get_node('../..').get_current_fullness(), get_node('../..').max_fullness))
