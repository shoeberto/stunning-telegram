extends "res://nodes/state_machine/state.gd"

var _target = null setget set_target, get_target

func exit():
    get_agent().set_current_path([])


func move(delta, destination):
    if !get_agent().get_animation_player().is_playing():
        get_agent().get_animation_player().play('walk')

    update_path(destination)
    get_agent().move_along_path(delta)


func update_path(destination):
    get_agent().set_current_path(
        get_tree().get_root().get_node('root/map/map').get_nav_path(
            get_agent().get_global_position(), 
            destination
        )
    )


func is_within_activation_range(destination):
    var distance = abs(get_agent().get_global_position().distance_to(destination))

    return distance <= get_agent().get_activation_range()


func is_task_done() -> bool:
    return false


func find_consumable_target(group_name):
    var nodes = get_tree().get_nodes_in_group(group_name)

    var available = []
    for n in nodes:
        if !n.is_available():
            available.append(n)

    if available.size() == 0:
        set_target(null)
        get_agent().set_current_path([])
        return

    var rng = RandomNumberGenerator.new()
    rng.randomize()
    var i = rng.randi_range(0, available.size() - 1)
    set_target(available[i])
    update_path(get_target().get_global_position())


func find_occupyable_target(group_name):
    var nodes = get_tree().get_nodes_in_group(group_name)

    var available = []
    for n in nodes:
        if !n.is_occupied():
            available.append(n)

    if available.size() == 0:
        set_target(null)
        get_agent().set_current_path([])
        return

    var rng = RandomNumberGenerator.new()
    rng.randomize()
    var i = rng.randi_range(0, available.size() - 1)
    set_target(available[i])
    update_path(get_target().get_global_position())


func set_target(target):
    _target = target

func get_target():
    return _target
