extends Node2D

@onready var button_operator_01 	: Button = $Panel/Button_01
@onready var button_operator_02 	: Button = $Panel/Button_02 
@onready var button_operator_03 	: Button = $Panel/Button_03
@onready var button_operator_04 	: Button = $Panel/Button_04
@onready var button_operator_05 	: Button = $Panel/Button_05
@onready var button_operator_06 	: Button = $Panel/Button_06
@onready var button_operator_07 	: Button = $Panel/Button_07
@onready var button_operator_08 	: Button = $Panel/Button_08

func _ready() -> void:
	MyUtil.adb_command_completed.connect(on_adb_command_completed)
	
	# 设置文本
	button_operator_01.text = MyContext.getString(MyString.ADB_DEVICE)
	button_operator_02.text = MyContext.getString(MyString.ADB_ROOT)
	button_operator_03.text = MyContext.getString(MyString.ADB_REMOUNT)
	button_operator_04.text = MyContext.getString(MyString.ADB_REBOOT)
	button_operator_05.text = MyContext.getString(MyString.ADB_MODE_DAY)
	button_operator_06.text = MyContext.getString(MyString.ADB_MODE_NIGHT)
	button_operator_07.text = MyContext.getString(MyString.ADB_APK_PUSH)
	button_operator_08.text = MyContext.getString(MyString.ADB_APK_INSTALL)
	
	# 设置按钮的点击事件
	button_operator_01.connect("button_down", clickButtonADBdevice)
	button_operator_02.connect("button_down", clickButtonADBroot)
	button_operator_03.connect("button_down", clickButtonADBremount)
	button_operator_04.connect("button_down", clickButtonADBreboot)
	button_operator_05.connect("button_down", clickButtonADBmodeDay)
	button_operator_06.connect("button_down", clickButtonADBmodeNight)
	button_operator_07.connect("button_down", clickButtonADBapkPush)
	button_operator_08.connect("button_down", clickButtonADBapkInstall)
	pass


func clickButtonADBdevice():
	# 需要执行的命令
	var command = ["devices"]
	# 调用执行单条命令的方法
	exe_sigle_command(button_operator_01, command)
	pass

# 执行adb root 命令
func clickButtonADBroot():
	# 需要执行的命令
	var command = ["root"]
	# 调用执行单条命令的方法
	exe_sigle_command(button_operator_02, command)
	pass

func clickButtonADBremount():
	# 需要执行的命令
	var command = ["remount"]
	# 调用执行单条命令的方法
	exe_sigle_command(button_operator_03, command)
	pass


func clickButtonADBreboot():
	# 需要执行的命令
	var command = ["reboot"]
	# 调用执行单条命令的方法
	exe_sigle_command(button_operator_04, command)
	pass


func clickButtonADBmodeDay():
	# 需要执行的命令
	var command = ["shell","cmd","uimode","night","no"]
	# 调用执行单条命令的方法
	exe_sigle_command(button_operator_05, command)
	pass

func clickButtonADBmodeNight():
	# 需要执行的命令
	var command = ["shell","cmd","uimode","night","yes"]
	# 调用执行单条命令的方法
	exe_sigle_command(button_operator_06, command)
	pass

func clickButtonADBapkPush():
	# 找到工作空间的路径
	var dirPath = MyUtil.get_data(MyConstant.SettingKey.FILE_DIR_PATH)
	var file_array = MyUtil.get_kind_file_recursive("apk",dirPath);
	button_operator_07.disabled = true
	# 需要执行的命令
	for path in file_array:
		# 需要找到 目录 /system/priv-app
		var apk_name = path.get_file()
		var dir_name = apk_name.get_basename()
		var command1 = ["shell","mkdir","-p", "/system/priv-app/%s" % dir_name]
		MyUtil.execute_adb_command(MyConstant.SignalADBType.SIGNAL_ADB_TYPE_MIDDLE,command1)
		# 延迟几秒钟
		await get_tree().create_timer(3.0).timeout
		var command2 = ["push", path, "/system/priv-app/%s/"%dir_name]
		# 调用执行单条命令的方法
		exe_sigle_command(button_operator_07, command2)
	pass

func clickButtonADBapkInstall():
	# 找到工作空间的路径
	var dirPath = MyUtil.get_data(MyConstant.SettingKey.FILE_DIR_PATH)
	var file_array = MyUtil.get_kind_file_recursive("apk",dirPath);
	# 需要执行的命令
	for path in file_array:
		MyUtil.sendMessageToArea(MyContext.getString(MyString.PLEASE_WAIT))
		var command = ["install","-r","-d", path]
		# 调用执行单条命令的方法
		exe_sigle_command(button_operator_08, command)
	pass

# 执行单条 adb 命令
func exe_sigle_command(button : Button, array: Array):
	# 点击时, 禁用掉当前的按钮
	button.disabled = true
	# 执行adb的命令
	MyUtil.execute_adb_command(MyConstant.SignalADBType.SIGNAL_ADB_TYPE_FINISH, array)
	# 延迟1秒钟时间
	await get_tree().create_timer(1.0).timeout
	# 取消按钮的禁用状态
	button.disabled = false
	pass

func on_adb_command_completed(adb_type: String, dictionary: Dictionary):
	# 发送结果给控制台
	var flag = dictionary.get("success")
	var output = dictionary.get("output")
	var outMessage = MyUtil.forwardArrayToString(output)
	if outMessage.is_empty():
		if flag:
			if adb_type == MyConstant.SignalADBType.SIGNAL_ADB_TYPE_FINISH:
				MyUtil.sendMessageToArea(MyContext.getString(MyString.OPERATION_SUCCESS))
			if adb_type == MyConstant.SignalADBType.SIGNAL_ADB_TYPE_MIDDLE:
				MyUtil.sendMessageToArea(MyContext.getString(MyString.PLEASE_WAIT))
		else:
			MyUtil.sendMessageToArea(MyContext.getString(MyString.OPERATION_FAILED))
	else:
		# 转换成为字符串效果
		MyUtil.sendMessageToArea(outMessage)
	pass
