extends Node2D

@onready var button_rename_set 	: Button = $Panel/Button_01
@onready var button_rename_start : Button = $Panel/Button_02 
@onready var button_operator_01 	: Button = $Panel/Button_03
@onready var button_operator_02 	: Button = $Panel/Button_04
@onready var button_operator_03 	: Button = $Panel/Button_05

signal setRename()

func _ready() -> void:
	# 设置按钮的点击事件
	button_rename_set.connect("button_down", clickButtonRenameSet)
	button_rename_start.connect("button_down", clickButtonRenameStart)
	pass

# 设置重命名
func clickButtonRenameSet():
	print("设置重命名...")
	emit_signal("setRename")
	pass

# 开始重命名
func clickButtonRenameStart():
	print("开始重命名...")
	pass
