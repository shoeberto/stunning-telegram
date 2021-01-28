extends "res://nodes/agents/meters/meter.gd"


func _physics_process(delta):
    set_value(calculate_progress(owner.owner.get_current_awakeness(), owner.owner.MAX_AWAKENESS))