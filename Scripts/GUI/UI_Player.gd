extends Control

@onready var Healt = $HeltPlayer
@onready var Ball = $FireBall

func update_health_bar(curHp, maxHp):
	Healt.value = (100/maxHp) * curHp
	
func update_fireBall_text(FireBall):
	Ball.text = "Bolas de fuego: " + str(FireBall)
