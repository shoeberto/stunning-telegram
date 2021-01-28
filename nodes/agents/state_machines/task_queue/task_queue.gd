class_name TaskQueue
extends Node


var task_queue = []

func _ready():
    for child in get_children():
        var err = child.connect("finished", self, "_next_task")
        append_task(child)
        if err:
            printerr(err)
            
    var current = get_current_task()
    
    if current:
        current.enter()


func update(delta):
    get_current_task().update(delta)


func handle_input(event):
    pass

func get_current_task():
    if task_queue.size() > 0:
        return task_queue[0]
    else:
        return null


func push_task_front(task):
    return task_queue.push_front(task)


func pop_task_front():
    return task_queue.pop_front()


func append_task(task):
    task_queue.append(task)


func pop_task_end():
    task_queue.pop_back()

func _next_task():
    var task = get_current_task()
    if task:
        task.exit()

    var next = pop_task_front()
    if next:
        next.enter()
        
func get_agent():
    return get_parent().get_agent()