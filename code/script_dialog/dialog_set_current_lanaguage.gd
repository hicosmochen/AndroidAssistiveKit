extends Node2D

@onready var labelTitle : Label = $Panel/Label_title
@onready var buttonLanaguageZh : Button = $Panel/Button_language_01
@onready var buttonLanaguageEn : Button = $Panel/Button_language_02


func _ready() -> void:
	labelTitle.text = MyContext.getString(MyString.SET_LANGUAGE)
	buttonLanaguageZh.text = MyContext.getString(MyString.LANAGUAGE_CHINESE)
	buttonLanaguageEn.text = MyContext.getString(MyString.LANAGUAGE_ENGLISH)
	
	buttonLanaguageZh.connect("button_down", clickButtonLanaguageZh)
	buttonLanaguageEn.connect("button_down", clickButtonLanaguageEn)
	pass

func clickButtonLanaguageZh():
	print("点击了 ZH")
	MyUtil.set_data(MyConstant.SettingKey.CURRENT_LANGUAGE, MyConstant.LanguageType.ZH)
	# 关闭当前的对话框场景
	queue_free()
	# 重新加载整个场景
	get_tree().reload_current_scene()
	pass

func clickButtonLanaguageEn():
	print("点击了 EN")
	MyUtil.set_data(MyConstant.SettingKey.CURRENT_LANGUAGE, MyConstant.LanguageType.EN)
	# 关闭当前的对话框场景
	queue_free()
	# 重新加载整个场景
	get_tree().reload_current_scene()
	pass
