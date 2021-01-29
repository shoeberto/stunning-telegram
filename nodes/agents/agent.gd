class_name Agent
extends KinematicBody2D

export var max_fullness: float = 100.0
export var max_awakeness: float = 100.0
export var max_harvest: float = 100.0

export var fullness_decay: float = 0.25
export var awakeness_decay: float = 0.25
export var harvest_rate: float = 0.25

export var speed: float = 1.0 setget set_speed, get_speed
export var activation_range: float = 1.0 setget set_activation_range, get_activation_range

var _current_fullness: float setget set_current_fullness, get_current_fullness
var _current_awakeness: float setget set_current_awakeness, get_current_awakeness
var _current_harvest: float setget set_current_harvest, get_current_harvest

var _current_path: Array setget set_current_path, get_current_path

var _current_state_label = ''

var _remaining_motion = null

# Called when the node enters the scene tree for the first time.
func _ready():
    set_current_fullness(max_fullness)
    set_current_awakeness(max_awakeness)

func set_current_fullness(fullness: float):
    if fullness < 0:
        fullness = 0

    _current_fullness = fullness

func get_current_fullness() -> float:
    return _current_fullness

func set_current_awakeness(awakeness: float):
    if awakeness < 0:
        awakeness = 0

    _current_awakeness = awakeness

func get_current_awakeness() -> float:
    return _current_awakeness


func decay(delta):
    if !is_sleeping():
        set_current_awakeness(get_current_awakeness() - (awakeness_decay * delta))

    if !is_eating():
        set_current_fullness(get_current_fullness() - (fullness_decay * delta))


func _on_StateMachine_state_changed(current_state):
    _current_state_label = current_state

func update_state_label(extra_text):
    var label = 'State: %s' % _current_state_label

    if extra_text != '':
        label = '%s\n%s' % [label, extra_text]

    get_node('./StateLabel').set_text(label)

func set_speed(new_speed: float):
    speed = new_speed

func get_speed() -> float:
    return speed

func set_activation_range(new_activation_range: float):
    activation_range = new_activation_range

func get_activation_range() -> float:
    return activation_range

func get_animation_player():
    return get_node("AnimationPlayer")

func stop_animation():
    get_animation_player().stop(false)

func set_current_path(new_path):
    _current_path = new_path

func get_current_path():
    return _current_path

func move_along_path(delta):
    if _current_path.size() == 0:
        return
    var last_point = get_position()
    var global_next = _current_path[0]
    var distance_between_points = last_point.distance_to(global_next)
    if distance_between_points >= 0:
        # The position to move to falls between two points.
        var kinematic_motion = null
        if _remaining_motion:
            kinematic_motion = _remaining_motion
            move_and_slide(_remaining_motion, Vector2(), false, 25)
        else:
            kinematic_motion = last_point.direction_to(global_next) * self.get_speed()
            # collision = move_and_slide(kinematic_motion)
            move_and_slide(kinematic_motion, Vector2(), false, 25)

        if get_slide_count() > 0:
            var reflect = kinematic_motion.bounce(get_slide_collision(0).normal)
            move_and_slide(reflect, Vector2(), false, 25)
            _remaining_motion = reflect
        else:
            _remaining_motion = null
    else:
        _current_path.remove(0)


func set_current_harvest(new_harvest):
    _current_harvest = new_harvest

func get_current_harvest():
    return _current_harvest

func add_harvest(amount):
    set_current_harvest(get_current_harvest() + amount)

func harvest(delta, consumable):
    var amount = harvest_rate * delta
    amount = consumable.consume(amount)
    add_harvest(amount)

func add_awakeness(amount):
    set_current_awakeness(get_current_awakeness() + amount)

func sleep(delta):
    add_awakeness(awakeness_decay * delta)

func is_sleeping():
    return is_task_running('Sleep')

func is_working():
    return is_task_running('Work')

func is_eating():
    pass

func is_task_running(name) -> bool:
    var current_state = get_node('StateMachine').current_state.name

    if current_state != 'PerformingTask':
        return false

    var current_task = get_node("StateMachine/PerformingTask/TaskQueue").get_current_task()

    if current_task == null:
        return false

    return current_task.name == name
