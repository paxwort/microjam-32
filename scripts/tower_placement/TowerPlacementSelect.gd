extends Node
@export var tower : PackedScene
signal selected

func select():
	%TowerPlacementCursor.tower_prefab = tower
	selected.emit()
