extends Node2D

@onready var human = get_node("Human")

func _ready() -> void:
	$Camera2D/CanvasLayer/Interface.visible = true

func direct_human(node) -> void:
	pass

func _process(delta: float) -> void:
	pass
