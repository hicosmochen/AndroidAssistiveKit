extends Node2D

@onready var lineEditPrefix: LineEdit = $Panel/LineEdit_prefix
@onready var lineEditDeigits: LineEdit = $Panel/LineEdit_deigits
@onready var buttonConfirm: Button = $Panel/Button_confirm
@onready var buttonCancel: Button = $Panel/Button_cancel
@onready var labelTitle : Label = $Panel/Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	labelTitle.text = MyContext.getString(MyString.FILE_RENAMING_OPTION_SETTINGS)
	buttonConfirm.text = MyContext.getString(MyString.CONFIRM)
	buttonCancel.text = MyContext.getString(MyString.CANCEL)
	
	lineEditPrefix.placeholder_text = MyContext.getString(MyString.ENTER_THE_PREFIX_TO_RENAME)
	lineEditDeigits.placeholder_text = MyContext.getString(MyString.ENTER_THE_NUMBER_OF_BITS_TO_RENAME)
	
	# 获取当前系统缓存的重命名信息
	var modelFileNode = get_node(MyConstant.NodeRoute.MODEL_FILE)
	if modelFileNode and modelFileNode.has_method(MyConstant.SignalMethod.GET_FILE_PARAM_PREFIX):
		lineEditPrefix.text = modelFileNode.getFileParamPrefix()
	if modelFileNode and modelFileNode.has_method(MyConstant.SignalMethod.GET_FILE_PARAM_DEIGITS):
		lineEditDeigits.text = str(modelFileNode.getFileParamDeigits())
	
	# 设置光标闪烁
	lineEditPrefix.caret_blink = true
	lineEditDeigits.caret_blink = true
	# 设置光标在输入框的末尾
	lineEditPrefix.caret_column = lineEditPrefix.text.length()
	lineEditDeigits.caret_column = lineEditDeigits.text.length()

	buttonConfirm.connect("button_down", checkInputData)
	buttonCancel.connect("button_down", clickButtonCancel) 
	lineEditPrefix.grab_focus()
	pass # Replace with function body.

# 点击了确定按钮
func clickButtonConfirm():
	# 获取文件的命名前缀
	var prefix = lineEditPrefix.text
	var deigits = lineEditDeigits.text
	MyUtil.sendMessageToArea(MyContext.getString(MyString.THE_PREFIX_FOR_RENAMING_IS)+ str(prefix))
	MyUtil.sendMessageToArea(MyContext.getString(MyString.THE_NUMBER_OF_DIGITS_FOR_RENAMING)+ str(deigits))
	# 需要将数据发送到组中 
	var filePath = MyUtil.get_data(MyConstant.SettingKey.FILE_DIR_PATH)
	get_tree().call_group(MyConstant.SignalName.SHOW_FILE_PARAM, MyConstant.SignalMethod.FILE_PREFIX_CHANGE,prefix)
	get_tree().call_group(MyConstant.SignalName.SHOW_FILE_PARAM, MyConstant.SignalMethod.FILE_DEIGITS_CHANGE,int(deigits))
	get_tree().call_group(MyConstant.SignalName.SHOW_FILE_PARAM, MyConstant.SignalMethod.FILE_PATH_CHANGE, filePath)
	# 将当前的场景, 清理掉
	self.queue_free()
	pass

# 点击取消按钮
func clickButtonCancel():
	# 将当前的场景, 清理掉
	self.queue_free()
	pass


func checkInputData():
	# 获取文件的命名前缀
	var prefix = lineEditPrefix.text
	var deigits = lineEditDeigits.text
		# 校准当前输入的是正确的命名
	if prefix.is_empty():
		lineEditPrefix.text = ""
		lineEditPrefix.placeholder_text = MyContext.getString(MyString.NAMING_PREFIX_CANNOT_BE_EMPTY)
		lineEditPrefix.add_theme_color_override("font_placeholder_color", Color.RED)
		# 1秒后恢复颜色
		await get_tree().create_timer(1.0).timeout
		lineEditPrefix.placeholder_text = MyContext.getString(MyString.NAME_PREFIX_OF_INPUT_FILE)
		lineEditPrefix.add_theme_color_override("font_placeholder_color", Color("#64646499"))	
	# 校准当前输入的是否是数字 
	elif deigits < "1" or deigits > "9" :
		lineEditDeigits.text = ""
		lineEditDeigits.placeholder_text = MyContext.getString(MyString.THE_NUMBER_OF_DIGITS_FOR_RENAMING)
		lineEditDeigits.add_theme_color_override("font_placeholder_color", Color.RED)
		# 1秒后恢复颜色
		await get_tree().create_timer(1.0).timeout
		lineEditDeigits.placeholder_text = MyContext.getString(MyString.INPUT_FILE_NAMING_LENGTH)
		lineEditDeigits.add_theme_color_override("font_placeholder_color", Color("#64646499"))
	else:
		# 如果校验的结果是正确的, 那么继续后续的操作
		clickButtonConfirm()
	pass
