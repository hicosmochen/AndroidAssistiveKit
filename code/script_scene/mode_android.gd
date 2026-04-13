extends Node2D

@onready var button_operator_01 	: Button = $Panel/Button_01
@onready var button_operator_02 	: Button = $Panel/Button_02 
@onready var button_operator_03 	: Button = $Panel/Button_03
@onready var button_operator_04 	: Button = $Panel/Button_04
@onready var button_operator_05 	: Button = $Panel/Button_05
@onready var button_operator_06 	: Button = $Panel/Button_06

func _ready() -> void:
	# 设置文本
	button_operator_01.text = MyContext.getString(MyString.ADB_DEVICE)
	button_operator_02.text = MyContext.getString(MyString.ADB_ROOT)
	button_operator_03.text = MyContext.getString(MyString.ADB_REMOUNT)
	button_operator_04.text = MyContext.getString(MyString.ADB_REBOOT)
	button_operator_05.text = MyContext.getString(MyString.ADB_MODE_DAY)
	button_operator_06.text = MyContext.getString(MyString.ADB_MODE_NIGHT)
	
	# 设置按钮的点击事件
	button_operator_01.connect("button_down", clickButtonADBdevice)
	button_operator_02.connect("button_down", clickButtonADBroot)
	button_operator_03.connect("button_down", clickButtonADBremount)
	button_operator_04.connect("button_down", clickButtonADBreboot)
	button_operator_05.connect("button_down", clickButtonADBmodeDay)
	button_operator_06.connect("button_down", clickButtonADBmodeNight)
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

# 执行单条 adb 命令
func exe_sigle_command(button : Button, array: Array):
	# 点击时, 禁用掉当前的按钮
	button.disabled = true
	# 执行adb的命令
	var dic = MyUtil.execute_adb_command(array)
	# 延迟1秒钟时间
	await get_tree().create_timer(1.0).timeout
	# 取消按钮的禁用状态
	button.disabled = false
	# 发送结果给控制台
	var flag = dic.get("success")
	var output = dic.get("output")
	var outMessage = MyUtil.forwardArrayToString(output)
	if outMessage.is_empty():
		if flag:
			MyUtil.sendMessageToArea(MyContext.getString(MyString.OPERATION_SUCCESS))
		else:
			MyUtil.sendMessageToArea(MyContext.getString(MyString.OPERATION_FAILED))
	else:
		# 转换成为字符串效果
		MyUtil.sendMessageToArea(outMessage)
	pass
