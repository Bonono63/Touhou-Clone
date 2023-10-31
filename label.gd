extends Label

func _process(_delta):
	text += "progress: "
	text = str(Main.scroll)
