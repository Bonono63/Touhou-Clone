class_name enemy
extends Node2D

var health : int = 0
var attack_pattern : int = 0
var movement_pattern : int = 0

func _init(_health : int, _attack_pattern : int, _movement_pattern : int):
	health = _health
	attack_pattern = _attack_pattern
	movement_pattern = _movement_pattern
