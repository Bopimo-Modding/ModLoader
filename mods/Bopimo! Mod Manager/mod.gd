extends "GUMM_mod.gd"

func _initialize(scene_tree: SceneTree) -> void:
	replace_resource_at("res://Client/Assets/Textures/Logo/Logo.png", load_texture("mod://Textures/Logo.png"))
	replace_resource_at("res://Client/Scripts/GUI/Singleplayer/TitleMenu.gd", load_resource("mod://Scripts/Singleplayer/TitleMenu.gd"))
	replace_resource_at("res://Client/Scenes/Singleplayer/TitleMenu.tscn", load_resource("mod://Scenes/TitleMenu.tscn"))
