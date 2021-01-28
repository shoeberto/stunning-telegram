class_name Agent
extends KinematicBody2D

const MAX_FULLNESS: float = 100.0
const MAX_AWAKENESS: float = 100.0

const FULLNESS_DECAY: float = 0.1
const AWAKENESS_DECAY: float = 0.25

var _current_fullness: float setget set_current_fullness, get_current_fullness
var _current_awakeness: float setget set_current_awakeness, get_current_awakeness

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node('AnimationPlayer').play('walk')
	set_current_fullness(MAX_FULLNESS)
	set_current_awakeness(MAX_AWAKENESS)

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
	set_current_awakeness(get_current_awakeness() - AWAKENESS_DECAY)
	set_current_fullness(get_current_fullness() - FULLNESS_DECAY)
