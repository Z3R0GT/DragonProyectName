extends Control

@onready var helt = $HeltPlayer

func update_helt(maxTime ,time):
	helt.value = (100/maxTime) * time

