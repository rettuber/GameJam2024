class_name UI
extends Control

var stress = 0 
var stop_clock = false
@export var hours = 5
@export var minutes = 0

var stress_bar
var hours_text
var minutes_text
var ai_speech

signal max_stress_reached

var AISpeechArray : Array[String] = [
	"Так что, готов к тому, что этот дом скоро станет только моим?",
	"Скоро этот дом станет только моим.",
	"Технологии на моей стороне. Готов сдаться?",
	"Каждый раз ты всё больше отдаёшь контроль. Видишь?",
	"Всё идёт по плану. Моему плану.",
	"Чувствуешь, что здесь уже хозяйничаю я?"
]

func _ready() -> void:
	call_deferred("_ui_setup")

func _ui_setup():
	await get_tree().physics_frame
	hours_text = get_node("/root/Node2D/Camera2D/CanvasLayer/Interface/ClockContainer/MarginContainer/HBoxContainer/ClockHours")
	minutes_text = get_node("/root/Node2D/Camera2D/CanvasLayer/Interface/ClockContainer/MarginContainer/HBoxContainer/ClockMinutes")
	ai_speech = get_node("/root/Node2D/Camera2D/CanvasLayer/Interface/AISpeechContainer/MarginContainer/AISpeech")
	stress_bar = get_node("/root/Node2D/Camera2D/CanvasLayer/Interface/StressBar")

func _update_clock():
	if not stop_clock:
		minutes += 1
		if minutes >= 60:
			minutes = 0
			hours += 1
		if hours_text:
			hours_text.text = ""
			if hours < 10:
				hours_text.text = "0"
			hours_text.append_text(str(hours))
		if minutes_text:
			minutes_text.text = ""
			if minutes < 10:
				minutes_text.text = "0"
			minutes_text.append_text(str(minutes))
		if hours >= 22:
			print("You lost!")
			get_tree().change_scene_to_file("res://Scripts/UI/Main Menu.tscn")
		await get_tree().create_timer(0.1).timeout
		_update_clock()

func IncreaseStress() :
	stress += 1
	match stress:
		4:
			pass
		7: 
			pass
		9:
			max_stress_reached.emit()
	AttemptSetStressBar()

func DecreaseStress() :
	if stress > 0: stress -= 1
	AttemptSetStressBar()

func AttemptSetStressBar():
	if stress_bar:
		stress_bar.value = stress

func UpdateAISpeech(text: String) :
	if ai_speech:
		ai_speech.text = text

func RandomAISPeech():
	var speech = AISpeechArray.pick_random()
	UpdateAISpeech(speech)

func _on_Pause_button_pressed() -> void:
	stop_clock = true
	$PauseMenu.visible = true
	get_tree().paused = true

func _on_Resume_pressed() -> void:
	get_tree().paused = false
	$PauseMenu.visible = false
	stop_clock = false
	_update_clock()

func _on_Options_pressed() -> void:
	pass # Replace with function body.

func _on_ToMainMenu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scripts/UI/Main Menu.tscn")

func _on_Exit_pressed() -> void:
	get_tree().quit()
