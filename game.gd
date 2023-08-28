extends Node3D

@onready var middle_room_tile = preload("res://tiles/middle_room.tscn")
@onready var corner_wall_tile = preload("res://tiles/corner_wall.tscn")
@onready var middle_wall_tile = preload("res://tiles/middle_wall.tscn")

const TILE_WIDTH:float = 5.0

var a = [[4],[6]]
var temp_map = [[0,7,7,7,3], [4,8,8,8,6], [4,8,8,8,6], [4,8,8,8,6], [1,5,5,5,2]]

var rotate_camera = false

func _ready():
	load_room(temp_map)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event.is_action_pressed("ui_quit"):
		get_tree().quit()

func load_room(map):
	for i in map.size():
		for j in map[i].size():
			var tile
			match map[i][j]:
				0:
					tile = corner_wall_tile.instantiate()
				1:
					tile = corner_wall_tile.instantiate()
					tile.rotation.y = PI*3/2
				2:
					tile = corner_wall_tile.instantiate()
					tile.rotation.y = PI
				3:
					tile = corner_wall_tile.instantiate()
					tile.rotation.y = PI/2
				4:
					tile = middle_wall_tile.instantiate()
				5:
					tile = middle_wall_tile.instantiate()
					tile.rotation.y = PI*3/2
				6:
					tile = middle_wall_tile.instantiate()
					tile.rotation.y = PI
				7:
					tile = middle_wall_tile.instantiate()
					tile.rotation.y = PI/2
				8:
					tile = middle_room_tile.instantiate()
			add_child(tile)
			tile.position.x = i * TILE_WIDTH
			tile.position.z = j * TILE_WIDTH
