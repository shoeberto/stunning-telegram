extends Node2D

export var max_amount_available: float = 100.0 setget set_max_amount_available, get_max_amount_available
export var amount_available: float = 100.0 setget set_amount_available, get_amount_available
export var regeneration_rate: float = 0.25 setget set_regeneration_rate, get_regeneration_rate

func _ready():
    set_physics_process(true)

func _physics_process(delta):
    regenerate(delta)

func set_amount_available(new_amount):
    if new_amount > max_amount_available:
        new_amount = max_amount_available

    amount_available = new_amount
    var pct = (amount_available / max_amount_available) * 100.0
    get_node('Meter').set_value(pct)

func get_amount_available():
    return amount_available

func set_max_amount_available(new_amount):
    max_amount_available = new_amount

func get_max_amount_available():
    return max_amount_available


func consume(amount):
    if get_amount_available() - amount < 0:
        amount = get_amount_available()

    set_amount_available(get_amount_available() - amount)
    return amount

func is_available():
    return (get_amount_available() / get_max_amount_available()) <= 0.1

func is_empty():
    return get_amount_available() == 0

func set_regeneration_rate(new_rate):
    regeneration_rate = new_rate

func get_regeneration_rate():
    return regeneration_rate

func regenerate(delta):
    set_amount_available(get_amount_available() + (get_regeneration_rate() * delta))
