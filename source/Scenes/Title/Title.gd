extends Control
@onready var any_key_player = $AnyKeyPlayer
@onready var background_player = $Background/AnimationPlayer

@onready var background = $Background

func _ready():
	set_process_input(false)
	Loader.begin_loading()
	
	await Loader.has_loaded_background
	background.texture = load("res://Assets/Textures/Background.png")
	background_player.play("Show")
	
	await Loader.has_finished
	any_key_player.play("Hide_load_animation")
	set_process_input(true)

func _input(event):
	if event.is_pressed():
		get_tree().change_scene_to_packed(Loader.game_scene)

func _on_animation_player_finished(_anim_name):
	if Loader.is_done:
		get_tree().change_scene_to_packed(Loader.game_scene)
