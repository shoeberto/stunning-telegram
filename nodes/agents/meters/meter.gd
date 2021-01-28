extends TextureProgress


func _ready():
    set_physics_process(true)



func calculate_progress(meter_value: float, meter_max: float) -> float:
    return get_max() * (meter_value / meter_max)

