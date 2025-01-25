class_name Maze extends Node

var cells : Array[Array]
var size_x : int = 20
var size_y : int = 20
signal created

func _ready():
	cells = []
	for x in range(0,size_x):
		cells.push_back([])
		for y in range(0, size_y):
			cells[x].push_back(randi_range(0,1))
	created.emit()
