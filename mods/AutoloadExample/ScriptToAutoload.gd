extends Control

var canvas : CanvasLayer = null

func _ready():
	canvas = load("user://mods/AutoloadExample/Scenes/Example.tscn").instantiate()
	self.add_child(canvas)
	