class_name Agent
extends KinematicBody2D

export var max_fullness: float = 100.0
export var max_awakeness: float = 100.0

export var fullness_decay: float = 0.25
export var awakeness_decay: float = 0.25

export var speed: float = 1.0 setget set_speed, get_speed

var _current_fullness: float setget set_current_fullness, get_current_fullness
var _current_awakeness: float setget set_current_awakeness, get_current_awakeness

# Called when the node enters the scene tree for the first time.
func _ready():
    get_node('AnimationPlayer').play('walk')
    set_current_fullness(max_fullness)
    set_current_awakeness(max_awakeness)

func set_current_fullness(fullness: float):
    if fullness < 0:
        return

    _current_fullness = fullness

func get_current_fullness() -> float:
    return _current_fullness

func set_current_awakeness(awakeness: float):
    if awakeness < 0:
        return

    _current_awakeness = awakeness

func get_current_awakeness() -> float:
    return _current_awakeness


func decay():
    set_current_awakeness(get_current_awakeness() - awakeness_decay)
    set_current_fullness(get_current_fullness() - fullness_decay)


func _on_StateMachine_state_changed(current_state):
    get_node('./StateLabel').set_text('State: %s' % current_state)

func set_speed(new_speed: float):
    speed = new_speed

func get_speed() -> float:
    return speed
