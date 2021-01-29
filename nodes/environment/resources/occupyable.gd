extends Node2D

var _occupant = null

func is_occupied():
    return _occupant != null


func occupy(occupant) -> bool:
    if is_occupied():
        return false

    _occupant = occupant
    get_node('Meter').set_value(100)
    return true


func leave(occupant) -> bool:
    if _occupant != occupant:
        return false
    
    _occupant = null
    get_node('Meter').set_value(0)
    return true


func get_occupant():
    return _occupant
