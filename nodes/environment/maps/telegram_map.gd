class_name TelegramMap
extends Node2D

onready var navigation = get_node('Navigation2D') setget set_navigation, get_navigation


func get_nav_path_between_entities(entity1, entity2):
    return get_nav_path(entity1.position, entity2.position)

func get_nav_path(p1, p2):
    p1 = get_navigation().to_local(p1)
    p2 = get_navigation().to_local(p2)
    var path = get_navigation().get_simple_path(p1, p2, true)
    path.remove(0)

    var updated = []
    for p in path:
        updated.append(get_navigation().to_global(p))
    return updated

func set_navigation(new_navigation):
    navigation = new_navigation

func get_navigation():
    return navigation
