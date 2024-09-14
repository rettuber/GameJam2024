class_name UI
extends Control

var stress = 0 
var stop_clock = false
@export var hours = 5
@export var minutes = 0

var hours_text
var minutes_text
var ai_speech

func _ready() -> void:
	call_deferred("_ui_setup")

func _ui_setup():
	await get_tree().physics_frame
	hours_text = get_node("ClockContainer/MarginContainer/HBoxContainer/ClockHours")
	minutes_text = get_node("ClockContainer/MarginContainer/HBoxContainer/ClockMinutes")
	ai_speech = get_node("AISpeechContainer/MarginContainer/AISpeech")
	_start_clock()

func _start_clock():
	while hours < 22:
		if not stop_clock:
			await get_tree().create_timer(0.1).timeout
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

func IncreaseStress() :
	stress += 1
	match stress:
		4:
			$StressBar.value = stress
		7: 
			$StressBar.value = stress
		10:
			pass

func DecreaseStress() :
	if stress > 0: stress -= 1

func UpdateAISpeech(text: String) :
	pass
