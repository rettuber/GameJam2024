extends Node

func _process(delta: float) -> void:
	await get_tree().create_timer(2).timeout
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Apartment.tscn")
	
