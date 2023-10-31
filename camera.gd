extends Camera3D

const scroll_modifier = 0.0005

var local_scroll = 0

func _ready():
	Main.connect("scroll_change", Callable(self, "on_scroll_change"))

func on_scroll_change(scroll : int):
	local_scroll = scroll

func _process(delta):
	position.z = lerp(position.z, -local_scroll*scroll_modifier, 1)
