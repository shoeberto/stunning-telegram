class_name PerformingTask
extends "res://nodes/state_machine/state.gd"

export var work_credits = 1

var _runtime: float = 0.0
onready var _task_queue = get_node('./TaskQueue')


func enter():
    _runtime = 0.0

func exit():
    _runtime = 0.0


func handle_input(_event):
    pass


func update(_delta):
    if _runtime < work_credits:
        _runtime = _runtime + _delta
        _task_queue.update(_delta)
    else:
        emit_signal('finished', 'biological')


func _on_animation_finished(_anim_name):
    pass
