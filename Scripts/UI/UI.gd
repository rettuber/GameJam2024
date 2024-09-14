class_name UI
extends Control

var stress = 0 

func IncreaseStress() :
	stress += 1
	match stress:
		4:
			$StressBar.value = stress
		7: 
			$StressBar.value = stress
		10:
			pass

func UpdateAISpeech(text: String) :
	%AISpeech.text = text

func UpdateClock():
	pass
