extends Node2D

@onready var labelVersion : Label = $ColorRect/Label

var versionName : String = "2026.03.19"

func _ready() -> void:
	# 设置当前的版本
	labelVersion.text = MyContext.getString(MyString.CURRENT_VERSION) + str(versionName)
	pass
