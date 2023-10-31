class_name level
extends Node2D

var spawn_schedule : Array[Array] = [
	#Time,Type,pos x,pos y
	#ie: [300,0,256,32]
]

var title : String

func _init(schedule : Array[Array], _title : String):
	spawn_schedule = schedule
	title = _title

func _ready():
	Main.connect("scroll_change", Callable(self, "on_scroll"))

func on_scroll(scroll : int) -> void:
	var removed_enemies : Array = []
	var index = 0
	while index < spawn_schedule.size():
		var enemy = spawn_schedule[index]
		if enemy[0] == scroll:
			print(index)
			spawn_enemy(enemy)
			removed_enemies.append(enemy)
		
		index +=1
	
	for enemy in removed_enemies:
		spawn_schedule.erase(enemy)

func spawn_enemy(enemy : Array) -> void:
	var child
	match enemy[1]:
		0:
			child = preload("res://drone.tscn").instantiate()
			child.init(get_node("Player"))
	
	child.position.x = enemy[2]
	child.position.y = enemy[3]
	print_debug("Spawned a poopling")
	add_child(child)
