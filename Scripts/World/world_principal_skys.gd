extends Node3D


@onready var SunMoon = $SunMoon/AnimationPlayer
@onready var Enviroment = $WorldEnvironment/AnimationPlayer

func _ready():
	SunMoon.play("SunRate")
	Enviroment.play("SkyChange")
