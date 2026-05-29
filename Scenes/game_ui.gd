extends CanvasLayer

func update_score(newScore: int):
	$Label.text = "Score: %s" % newScore
