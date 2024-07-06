extends Node3D
enum {
	OverLook,TridPerson,SideScrolling
}
enum {
	mouseleft,mouseright,wasd
}
@onready var ButtonEnter = false
@onready var gamemode = OverLook
@onready var overlook_mode = mouseleft
@onready var map_size:Vector3
@onready var map = "overlook_map_1"
@onready var character = "Suzanne_001"
func _ready() -> void:
	set_volume(1 ,0.1)
	set_volume(2 ,0.16)
	print(overlook_mode)
func get_volume(bus_index:int)->float:
	var db := AudioServer.get_bus_volume_db(bus_index)
	return db_to_linear(db)
func set_volume(bus_index:int,v:float)->void:
	var db: = linear_to_db(v)
	AudioServer.set_bus_volume_db(bus_index,db) 
func change_character(player,skin):
	print(skin)
	var characterpath = "res://game/character/{str}.tscn"
	var character_skin = load(characterpath.format({"str":skin})).instantiate()
	var characterRotationRoot = player.get_node("characterRotationRoot")
	var c = characterRotationRoot.get_children()
	for obj in c:
		obj.queue_free()
	characterRotationRoot.add_child(character_skin)
	player.character_skin = character_skin
func load_map(map,map_box,mode:int = 0):
	var mappath = "res://game/map/{str}.tscn"
	var map_s = load(mappath.format({"str":map}))
	if mode ==0:
		var map_in = map_s.instantiate()
		map_box.add_child(map_in)
	elif mode == 1: 
		var map_q = map_s.instantiate()
		map_size = map_q.map_size
		if map_size == Vector3.ZERO:
			return
		map_q.queue_free()
		var map_c = map_box.get_children()
		for obj in map_c:
			obj.queue_free()
		var list1 = [
			Vector2(0,0),
			Vector2(0,map_size.z),
			Vector2(0,-map_size.z),
			Vector2(map_size.x,0),
			Vector2(-map_size.x,0),
			Vector2(map_size.x,map_size.z),
			Vector2(-map_size.x,map_size.z),
			Vector2(map_size.x,-map_size.z),
			Vector2(-map_size.x,-map_size.z)
			]
		for i in range(9):
			var map_in = map_s.instantiate()
			map_in.position = Vector3(list1[i].x,0,list1[i].y)
			map_box.add_child(map_in)
