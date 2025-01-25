class_name WaveParser
extends Node

static func ParseJsonWaveData(json_string: String):
	var json_data = JSON.parse_string(json_string)
	var waves = {}
	for key in json_data:
		var wave_queue: Array[SpawnCommand] = []
		var wave_data = json_data[key]
		for wave_section in wave_data:
			var section = SpawnCommand.new()
			section.type = wave_section["type"]
			section.count = wave_section["count"]
			section.wait_time = wave_section["wait_time"]
			wave_queue.append(section)
		waves[key] = wave_queue
	return waves
