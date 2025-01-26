extends Node
# just passes on a signal, it's an organisation thing
signal relay
func do_signal() -> void:
	relay.emit()
