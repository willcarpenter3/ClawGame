class_name GameUI
extends CanvasLayer

func _init() -> void:
	GameManager.game_ui = self

func update_score_text(newScore: int):
	$Label.text = "Score: %s" % newScore

func update_button_statuses(newScore: int):
	$HBoxContainer/UpgradeSpeedButton.disabled = newScore <= 0
	$HBoxContainer/BuyAutoClawButton.disabled = newScore <= 1
	$HBoxContainer/BuyBombButton.disabled = newScore <= 2

func _on_upgrade_speed_button_pressed() -> void:
	if GameManager.score <= 0:
		return
	
	GameManager.update_claw_speed()


func _on_buy_auto_claw_button_pressed() -> void:
	if GameManager.score <= 1:
		return
		
	GameManager.buy_auto_claw()



func _on_buy_bomb_button_pressed() -> void:
	if GameManager.score <= 2:
		return
		
	GameManager.buy_bomb()
