extends CanvasLayer

func _ready() -> void:
	%VersionLabel.text = Bopimo.GAME_VERSION
	for dir in DirAccess.get_directories_at("user://mods/"):
		
		var data : Dictionary = {
			"load_path" = "user://mods/" + dir,
			"active" = ("user://mods/" + dir) in GetModConfig()
		}
		var entry: Control = preload("user://mods/Bopimo! Mod Manager/Scenes/Mods/ModEntry.tscn").instantiate()
		%ModList.add_child(entry)
		entry.owner = self
		entry.set_mod(Registry.GameData.ModData.new(data))
		
func apply_mods() -> void:
	var active_mods : PackedStringArray
	for mod_entry in %ModList.get_children(): 
		if mod_entry.metadata.active: active_mods.append(mod_entry.metadata.load_path)
	SaveModConfig(active_mods)

func _on_close_pressed() -> void:
	#DirectoryManager.SaveGameSettings() # Saves game settings on close to avoid rapid updating from any sliders
	hide()

func SaveModConfig(enabled_mods_list : PackedStringArray) -> void:
	var file : FileAccess = FileAccess.open("user://settings/mods_config.JSON",FileAccess.WRITE)
	file.store_string(JSON.stringify(enabled_mods_list))

func GetModConfig() -> PackedStringArray:
	var PATH : String = "user://settings/mods_config.JSON"
	var new_array : PackedStringArray = []
	if FileAccess.file_exists(PATH):
		var new_json : String = FileAccess.get_file_as_string(PATH)
		var parsed_json : Variant = JSON.parse_string(new_json)

		if parsed_json is Array:
			for string in parsed_json:
				new_array.append(string)
				DebugOld.debug_print("Mod config loaded successfully.", DebugOld.print_channels.WORLD)
		else:
				DebugOld.debug_print("Could not load mod config: settings/mod_config.JSON is not an Array", DebugOld.print_channels.WORLD,true)
	else:
		DebugOld.debug_print("Could not load mod config: settings/mod_config.JSON does not exist", DebugOld.print_channels.WORLD,true)

	return new_array
