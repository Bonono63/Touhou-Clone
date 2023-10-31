extends Node2D

signal complete

# time in seconds before the subwave begins
@export var time : float

func init(_time:float):
	time = _time

func _ready():
	self.hide()
	
	await get_tree().create_timer(time).timeout
	
	self.show()

func _process(delta):
	$Path2D/PathFollow2D.progress += 500*delta
	
	var num_left = 0
	for child in get_children(true):
		if child.is_in_group("enemy"):
			num_left += 1
	
	if num_left == 0:
		emit_signal("complete")
