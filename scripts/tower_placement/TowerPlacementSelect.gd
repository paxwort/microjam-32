extends Node
@export var tower : TowerData
signal selected

func select():
	%TowerPlacementCursor.tower_data = tower
	selected.emit()
