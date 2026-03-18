extends Node2D

@onready var lineEditPrefix: LineEdit = $Panel/LineEdit_prefix
@onready var lineEditDeigits: LineEdit = $Panel/LineEdit_deigits
@onready var buttonConfirm: Button = $Panel/Button_confirm
@onready var buttonCancel: Button = $Panel/Button_cancel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# 获取当前系统缓存的重命名信息
	var modelFileNode = get_node("/root/Main/ModelFile")
	if modelFileNode and modelFileNode.has_method("getFileParamPrefix"):
		lineEditPrefix.text = modelFileNode.getFileParamPrefix()
	if modelFileNode and modelFileNode.has_method("getFileParamDeigits"):
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
	MyUtil.sendMessageToArea("重命名的前缀是: "+ str(prefix))
	MyUtil.sendMessageToArea("重命名的位数是: "+ str(deigits))
	# 需要将数据发送到组中 
	get_tree().call_group("show_file_param","filePrefixChange",prefix)
	get_tree().call_group("show_file_param","fileDeigitsChange",int(deigits))
	get_tree().call_group("show_file_param", "filePathChange", MyUtil.get_data("file_dir_path"))
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
		lineEditPrefix.placeholder_text = "命名前缀不能为空"
		lineEditPrefix.add_theme_color_override("font_placeholder_color", Color.RED)
		# 1秒后恢复颜色
		await get_tree().create_timer(1.0).timeout
		lineEditPrefix.placeholder_text = "输入文件的命名前缀"
		lineEditPrefix.add_theme_color_override("font_placeholder_color", Color("#64646499"))	
	# 校准当前输入的是否是数字 
	elif deigits < "1" or deigits > "9" :
		lineEditDeigits.text = ""
		lineEditDeigits.placeholder_text = "命名位数只能是 1-9 的数字"
		lineEditDeigits.add_theme_color_override("font_placeholder_color", Color.RED)
		# 1秒后恢复颜色
		await get_tree().create_timer(1.0).timeout
		lineEditDeigits.placeholder_text = "输入文件的命名位数"
		lineEditDeigits.add_theme_color_override("font_placeholder_color", Color("#64646499"))
	else:
		# 如果校验的结果是正确的, 那么继续后续的操作
		clickButtonConfirm()
	pass
