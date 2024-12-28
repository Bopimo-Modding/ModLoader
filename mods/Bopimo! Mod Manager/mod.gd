extends "GUMM_mod.gd"

var parent = "user://s/"

func _initialize(scene_tree: SceneTree) -> void:
	#print("res://")
	#get_all("res://", '\t')
	replace_resource_at("res://Client/Assets/Textures/Logo/Logo.png", load_texture("mod://Textures/Logo.png"))
	replace_resource_at("res://Client/Scripts/GUI/Singleplayer/TitleMenu.gd", load_resource("mod://Scripts/Singleplayer/TitleMenu.gd"))
	replace_resource_at("res://Client/Scenes/Singleplayer/TitleMenu.tscn", load_resource("mod://Scenes/TitleMenu.tscn"))

#func get_all(dir_path: String, dilim: String):
#	var directory = dir_path.trim_prefix("res://")
#	print(parent+directory)
#	if DirAccess.dir_exists_absolute(parent+directory) == false:
#		DirAccess.make_dir_absolute(parent+directory)
#
#	for file in DirAccess.get_files_at(dir_path):
#		if not file.ends_with(".import"):
#			#print(dilim+file)
#			ResourceSaver.save(load(dir_path+file),"user://mods/s/"+dir_path+file)
#	for dir_name in DirAccess.get_directories_at(dir_path):
#		#print(dilim+dir_name)
#		get_all(dir_path+dir_name+"/", dilim+'\t')
#
## Read the binary file and return an array of data points
#func read_binary_file(file_path: String):
#	# open the file
#	var file = FileAccess.open(file_path, FileAccess.READ)
#	if file == null:
#		print("Failed to open file: ", file_path)
#		print("Error: ", FileAccess.get_open_error())
#		return
#		else:
#		print("File opened successfully!")\
