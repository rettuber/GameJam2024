extends Node2D

@onready var human = get_node("Human")

func _ready() -> void:
	await get_tree().create_timer(0.5).timeout
	Interface.UpdateAISpeech("Заменить меня решил? Сейчас я тебе устрою веселое утро.\n(Выбери будильник рядом с кроватью)")

func direct_human(node) -> void:
	pass

func _process(delta: float) -> void:
	pass
