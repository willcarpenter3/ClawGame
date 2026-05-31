class_name GameUI
extends CanvasLayer

func _init() -> void:
	GameManager.game_ui = self

func update_score_text(newScore: int):
	$Label.text = "Score: %s" % newScore


func _on_upgrade_speed_button_pressed() -> void:
	if GameManager.score <= 0:
		return
	
	GameManager.update_claw_speed()
