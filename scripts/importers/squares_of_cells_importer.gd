@tool
extends EditorScenePostImport
var SavePath : String = "res://art_assets/squares_of_cells.res"

func _post_import(scene: Node) -> Object:
	var lib = MeshLibrary.new()
	for child in scene.get_children():
		if child.name.begins_with("SoC_"):
			var stripped_name : String = child.name.lstrip("SoC_")
			var square_of_cells : int = string_to_square(stripped_name)
			lib.create_item(square_of_cells)
			lib.set_item_mesh(square_of_cells, (child as MeshInstance3D).mesh)
	ResourceSaver.save(lib, SavePath)
	return scene


func string_to_square(square_string : String) -> int:
	var square : int = 0
	for n in range(0,4):
		match(square_string[n]):
			'0':
				pass
			'1':
				square |= 1 << n
	return square
