extends "res://nodes/agents/state_machines/task_queue/states/task_state.gd"


var _target = null setget set_target, get_target

# Initialize the state. E.g. change the animation.
func enter():
    var nodes = get_tree().get_nodes_in_group("work_items")
    var rng = RandomNumberGenerator.new()
    rng.randomize()
    var i = rng.randi_range(0, nodes.size() - 1)
    set_target(nodes[i])


# Clean up the state. Reinitialize values like a timer.
func exit():
    set_target(null)


func handle_input(_event):
    pass


func update(_delta):
    var dir = get_agent().position.direction_to(get_target().position)
    var velocity = dir * get_agent().get_speed()
    var collision_info = get_agent().move_and_collide(velocity * _delta)
    if collision_info:
        velocity = velocity.bounce(collision_info.normal)



func _on_animation_finished(_anim_name):
    pass


func set_target(target):
    _target = target

func get_target():
    return _target
