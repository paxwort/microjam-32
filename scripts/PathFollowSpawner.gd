class_name EnemySpawner
extends Node3D

@export var WaveStructurePath = "res://data/wave_queues.json"

var PathFollower
var _path: Path3D

var WaveData: Dictionary
var SpawnQueue: Array = []
var LevelCounter = 0

var SpawnWaitTime = 0.0
var RemainingWaitTime = 0.0

var CurrentSpawnSet: SpawnCommand

@export var enemyTypes: Dictionary

func _init() -> void:
	PathFollower = preload("res://prefabs/enemies/enemy_path_follower.tscn")
	GameManager.reset_game_state.connect(_reset_level)

func _ready() -> void:
	_path = get_parent()
	_reset_level()

func _process(delta: float) -> void:
	if CurrentSpawnSet == null || CurrentSpawnSet.count <= 0:
		if SpawnQueue.size() == 0:
			return
		
		var next_block = SpawnQueue[0]
		SpawnQueue.remove_at(0)
		
		if next_block is not SpawnCommand:
			print("Invalid block type")
		
		SpawnWaitTime = next_block.wait_time
		CurrentSpawnSet = next_block
		
	RemainingWaitTime -= delta
	
	if(RemainingWaitTime <= 0):
		Spawn(CurrentSpawnSet.type)
		CurrentSpawnSet.count -= 1
		RemainingWaitTime = SpawnWaitTime
	

func Spawn(spawn_id: String) -> void:
	var toSpawn = enemyTypes[spawn_id]
	if(toSpawn == null):
		print("Enemy type %s not found" % spawn_id)
		return
	var enemy = toSpawn.instantiate()
	
	var pathFollow = PathFollower.instantiate().WithMovement(enemy.get_node("MovementNode"))
	
	pathFollow.add_child(enemy)
	_path.add_child(pathFollow)

func _load_file_as_string(file):
	var f = FileAccess.open(file, FileAccess.READ)
	var content = f.get_as_text()
	return content
	
func _load_level_wave():
	var level_name = "wave_%s" % LevelCounter
	if(WaveData.has(level_name) && WaveData[level_name].size() != 0):
		SpawnQueue = WaveData[level_name]
	else:
		print("No level data available for %s" % level_name)
		
func _reset_level() -> void:
	var json_string = _load_file_as_string(WaveStructurePath)
	WaveData = WaveParser.ParseJsonWaveData(json_string)
	LevelCounter = 0
	SpawnQueue = []
	SpawnWaitTime = 0
	RemainingWaitTime = 0

func _start_round() -> void:
	LevelCounter+=1
	print("Loading level %s" % LevelCounter)
	_load_level_wave()
