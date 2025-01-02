extends CanvasLayer

func _ready() -> void:
	%VersionLabel.text = ProjectSettings.get_setting_with_override("modloader/version_string")
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
	var autoloads : Array

	for mod_entry in %ModList.get_children(): 
		if mod_entry.metadata.active:
			active_mods.append(mod_entry.metadata.load_path)
			autoloads.append(mod_entry.metadata.autoloads)
	print(autoloads)
	SaveModConfig(active_mods)
	SaveAutoloads(autoloads)

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

func SaveAutoloads(autoloads_list) -> void:
	var config_file := ConfigFile.new()
	if config_file.load("user://override.cfg") != OK: #How did we get here???
		return

	#Clear all autoloads
	if config_file.has_section("autoload"):
		config_file.erase_section("autoload")

	for autoloads in autoloads_list:
		for autoload in autoloads:
			config_file.set_value("autoload", autoload, autoloads[autoload])

	# The Mod Manager wont be able to list out mods w/o this.
	if not config_file.has_section_key("autoload", "Registry"):
		config_file.set_value("autoload", "Registry", "*user://mods/Bopimo! Mod Manager/GUMM/Data/Registry.gd")

	#TODO: Add alert on failed save.
	config_file.save("user://override.cfg")
