extends Node2D

class wave:
	var title : String = ""
	var sub_waves : Array = []
	# List of active enemies in the wave
	var enemies : Array = []
	signal wave_began
	signal wave_ended
	
	func _init(_title:String, _subwaves:Array):
		sub_waves = _subwaves
		title = _title
	
	func _process(_delta):
		if check_enemy_integrity():
			emit_signal("wave_ended")
	
	func check_enemy_integrity() -> bool:
		for _sub_wave in sub_waves:
			for enemy in _sub_wave.enemies:
				if enemy.health > 0:
					return false
				else:
					return true
		return true

var current_wave : wave

func load_sub_wave(path : String, time : float, _position : Vector2):
	var _sub_wave = load(path)
	_sub_wave.init(time, _position)
	return _sub_wave

func clean_children() -> void:
	for child in get_children():
		child.queue_free()

func _ready():
	var wave_001 : wave = wave.new("Fairy Garden", [load_sub_wave("res://sub_wave_001.tscn", 5, Vector2(6,0))])
	current_wave = wave_001
	
	for _sub_wave in current_wave.sub_waves:
		add_child(_sub_wave)
	
	await current_wave.wave_ended
	
	clean_children()
