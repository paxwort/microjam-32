extends VSlider

@onready var bus = AudioServer.get_bus_index("Master")

func _ready():
	AudioServer.set_bus_volume_db(bus, linear_to_db(value / 100))

func _on_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bus, linear_to_db(value / 100))
