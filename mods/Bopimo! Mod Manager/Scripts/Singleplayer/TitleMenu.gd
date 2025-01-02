extends Node3D

@export_file var bop_file_path : String = ""
@onready var level : Level = Level.create(self)

func _ready() -> void:
	level.load_level_from_file(bop_file_path)
	
	# Sets labels of version information for the client as well as godot
	$UI/Version.text =  "%s | Modloader %s" % [Bopimo.GAME_VERSION, ProjectSettings.get_setting_with_override("modloader/version_string")]
	$UI/Godot.text = Bopimo.godot_info
	$UI/BuildInfo.text = Debug.get_builder_information_string()

func _process(delta: float) -> void:
	$CamPivot.rotate_y(delta * 0.2)

func _physics_process(delta) -> void:

	if Input.is_key_pressed(KEY_CTRL) and Input.is_key_pressed(KEY_B):
		(load("res://Client/Scripts/Benchmark.gd") as GDScript).initiate_shape_benchmark()
	if Input.is_key_pressed(KEY_CTRL) and Input.is_key_pressed(KEY_S):
		(load("res://Client/Scripts/StarLimitTest.gd") as GDScript).initiate_star_limit()
	if Input.is_key_pressed(KEY_BACKSPACE) and Input.is_key_pressed(KEY_B):
		get_tree().change_scene_to_file("res://Client/Scenes/Singleplayer/DebugChooseBase.tscn")

func _on_play_singleplayer_pressed() -> void:
	get_tree().change_scene_to_file("res://Client/Scenes/Singleplayer/SingleplayerChooseBase.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_settings_pressed() -> void:
	$UI/SettingsInterface.show()

func _on_tutorial_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Singleplayer/Tutorial.tscn")


func _on_close_pressed() -> void:
	$UI/JoinServerMenu.hide()


func _on_server_button_pressed() -> void:
	$UI/JoinServerMenu.show()


func _on_mods_pressed() -> void:
	#print("a")
	$UI/ModsInterface.show()
