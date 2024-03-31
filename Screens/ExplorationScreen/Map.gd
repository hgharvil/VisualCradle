extends Node3D

const _3D_TILE = preload("res://Objects/3DTile/3d_tile.tscn")
# (column, level, row, teleport coords(6,0,10) 
var current_map_array : Array[Array]
var current_node_array : Array[Array]

func _ready() -> void:
	#read the map from file, or something who knows, and return it into current_map_array
	#current_map_array = [
		#[[0,0,0,null,"N4"],[1,0,0,null,"N1"],[2,0,0,null,"N6"],[3,0,0,null,"N1"]]
	#]
	current_map_array = [
		[[0,0,0,null,"N0"],          [1,0,0,null,"N0"],[2,0,0,null,"N0"],[3,0,0,null,"N5"],[4,0,0,null,"N0"],[5,0,0,null,"N0"],[6,0,0,null,"N0"],[7,0,0,null,"N0"]],
		[[0,0,1,null,"N0"],          [1,0,1,null,"N6"],[2,0,1,null,"N6"],[3,0,1,null,"N1"],[4,0,1,null,"N6"],[5,0,1,null,"N6"],[6,0,1,null,"N0"],[7,0,1,null,"N0"]],
		[[0,0,2,null,"N0"],          [1,0,2,null,"N6"],[2,0,2,null,"N0"],[3,0,2,null,"N1"],[4,0,2,null,"N0"],[5,0,2,null,"N6"],[6,0,2,null,"N0"],[7,0,2,null,"N0"]],
		[[0,0,3,Vector3(7,0,7),"N4"],[1,0,3,null,"N6"],[2,0,3,null,"N0"],[3,0,3,null,"PO"],[4,0,3,null,"N0"],[5,0,3,null,"N6"],[6,0,3,null,"N0"],[7,0,3,null,"N0"]],
		[[0,0,4,null,"N0"],          [1,0,4,null,"N0"],[2,0,4,null,"N0"],[3,0,4,null,"N6"],[4,0,4,null,"N0"],[5,0,4,null,"N1"],[6,0,4,null,"N0"],[7,0,4,null,"N0"]],
		[[0,0,5,null,"N0"],          [1,0,5,null,"N0"],[2,0,5,null,"N0"],[3,0,5,null,"N1"],[4,0,5,null,"N0"],[5,0,5,null,"N0"],[6,0,5,null,"N0"],[7,0,5,null,"N0"]],
		[[0,0,6,null,"N0"],          [1,0,6,null,"N0"],[2,0,6,null,"N0"],[3,0,6,null,"N1"],[4,0,6,null,"N0"],[5,0,6,null,"N0"],[6,0,6,null,"N0"],[7,0,6,null,"N0"]],
		[[0,0,7,null,"N0"],          [1,0,7,null,"N0"],[2,0,7,null,"N0"],[3,0,7,null,"N1"],[4,0,7,null,"N1"],[5,0,7,null,"N1"],[6,0,7,null,"N1"],[7,0,7,null,"N5"]]
	]
	
	#instantiate map tiles based on current_map_array
	for i in current_map_array.size():
		current_node_array.append([])
		for j in current_map_array[0].size():
			#print("(",current_map_array[i][j][0],",",current_map_array[i][j][1],",",current_map_array[i][j][2],"),",current_map_array[i][j][3],",",current_map_array[i][j][4])
			var node = _3D_TILE.instantiate()
			add_child(node)
			node.global_position = Vector3(current_map_array[i][j][0] + 0.5, current_map_array[i][j][1] - 0.5, current_map_array[i][j][2] + 0.5)
			node.is_visited = false
			if current_map_array[i][j][3]:
				node.destination = current_map_array[i][j][3]
			node.label = current_map_array[i][j][4]
			
			current_node_array[i].append(node)

# position is (x,y,z); x = column; y = level; z = row; 
# current_map_array[z][x][0] + 0.5 = x pos
# current_map_array[z][x][1] - 0.5 = y pos
# current_map_array[z][x][2] + 0.5 = z pos
# current_map_array[z][x][3] = destination pos
# current_map_array[z][x][4] = label/number
# current_node_map[z][x] = 3DTile
func is_position(player_position : Vector3) -> bool:
	#print("Checking for: ",player_position)
	var result = false
	if player_position.x >= 0 and player_position.z >= 0:
		if player_position.z < current_node_array.size() and player_position.x < current_node_array[player_position.z].size():
			#print("(",current_map_array[position.z][position.x][0],",",current_map_array[position.z][position.x][1],",",current_map_array[position.z][position.x][2],"),",current_map_array[position.z][position.x][3],",",current_map_array[position.z][position.x][4])
			if current_node_array[player_position.z][player_position.x].label != "N0":
				result = true
	return result

func mark_tile_visited(player_position : Vector3):
	current_node_array[player_position.z][player_position.x].is_visited = true

func interact(player_position : Vector3):
	print("in map's interact(): player_position: ", player_position)
	pass
