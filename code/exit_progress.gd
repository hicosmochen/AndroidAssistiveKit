extends Node2D

@onready var button_cancel : Button = $Panel/Button_cancel
@onready var button_confirm : Button = $Panel/Button_confirm

func _ready() -> void:
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
