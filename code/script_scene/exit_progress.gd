extends Node2D

@onready var label_title   : Label = $Panel/Label
@onready var button_cancel : Button = $Panel/Button_cancel
@onready var button_confirm : Button = $Panel/Button_confirm

func _ready() -> void:
	label_title.text = MyContext.getString(MyString.ARE_YOU_SURE_YOU_WANT_TO_EXIT)
	button_confirm.text = MyContext.getString(MyString.CONFIRM)
	button_cancel.text = MyContext.getString(MyString.CANCEL)
	
	
	button_cancel.connect("button_down", clickButtonCancel)
	button_confirm.connect("button_down", clickButtonConfirm)
	pass

# 取消按钮
func clickButtonCancel():
	queue_free()
	pass

# 确定按钮
func clickButtonConfirm():
	get_tree().quit()
	pass
