extends Node

var texture_cache:Array[Resource]
var other_cache:Array[Resource]

var thread:Thread 
var game_scene:PackedScene

var is_done := false

signal has_finished
signal has_loaded_background

func _ready():
	RenderingServer.set_default_clear_color(Color.BLACK)

func begin_loading():
	thread = Thread.new()
	thread.start(load_persistent_assets)

func _process(_delta):
	if thread and not thread.is_alive():
		thread.wait_to_finish()
		has_finished.emit()
		is_done = true
		set_process(false)

func background_loaded():
	has_loaded_background.emit()

func load_persistent_assets():
	texture_cache.append(load("res://Assets/Textures/Background.png"))
	background_loaded.call_deferred()
	texture_cache.append_array(
		[load("res://Assets/Textures/Mercury_512.png"), 
		load("res://Assets/Textures/Neptune_512x256.png"), 
		load("res://Assets/Textures/Venus_512x256.png")])

	other_cache.append_array([load("res://Assets/Materials/GasGiant.material"),load("res://Assets/Materials/Venus.material")])
	game_scene = load("res://Game.tscn")
