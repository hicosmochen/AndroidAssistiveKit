extends Node2D

@onready var labelTitle : Label = $ColorRect/Label_title
@onready var labelEmail : Label = $ColorRect/Label_email

func _ready() -> void:
	
	labelTitle.text = MyContext.getString(MyString.CONTACT_THE_AUTHOR)
	labelEmail.text = "chcsvip@126.com"
	
	labelTitle.z_index = 0
	labelEmail.z_index = 0
	
	pass
