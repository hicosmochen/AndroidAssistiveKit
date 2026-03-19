extends Node2D

@onready var button_operator_01 	: Button = $Panel/Button_01
@onready var button_operator_02 	: Button = $Panel/Button_02 
@onready var button_operator_03 	: Button = $Panel/Button_03
@onready var button_operator_04 	: Button = $Panel/Button_04
@onready var button_operator_05 	: Button = $Panel/Button_05


func _ready() -> void:
	# 设置文本
	button_operator_01.text = MyContext.getString(MyString.ADB_ROOT)
	button_operator_02.text = MyContext.getString(MyString.ADB_REMOUNT)
	button_operator_03.text = MyContext.getString(MyString.ADB_REBOOT)
	button_operator_04.text = MyContext.getString(MyString.ADB_MODE_DAY)
	button_operator_05.text = MyContext.getString(MyString.ADB_MODE_NIGHT)
	
	 
	# 设置按钮的点击事件
	button_operator_01.connect("button_down", clickButtonRenameSet)
	button_operator_02.connect("button_down", clickButtonRenameStart)
	pass

func clickButtonRenameSet():
	pass

func clickButtonRenameStart():
	pass
