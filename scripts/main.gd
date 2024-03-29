extends Control


func _ready():
	if not OS.is_debug_build():
		OS.window_fullscreen = true


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
