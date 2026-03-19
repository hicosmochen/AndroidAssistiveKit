extends Node2D

@onready var splash		:Node = $Splash
@onready var mainMenu	:Node = $MainMenu

var current_scene_mode : Node

func _ready() -> void:
	
	# 监听信号, 当 splash 动画播放完毕之后的处理
	splash.connect(MyConstant.SignalName.SPLASH_ANIMATED_FINISH, splashAnimatedFinish)
	# 监听信号, 当 接收到退出程序的信号时
	mainMenu.connect(MyConstant.SignalMethod.DIALOG_EXIT_PROGRESS, dialog_exit_progress)
	# 监听信号, 当 接收到清理日志的信号时
	mainMenu.connect(MyConstant.SignalMethod.DIALOG_CLEAR_SYSTEM_LOG, dialog_clear_system_log)
	# 监听信号, 当 接收到设置当前语言信号时
	mainMenu.connect(MyConstant.SignalMethod.DIALOG_SET_CURRENT_LANAGUAGE, dialog_set_current_lanaguage)
	# 监听信号, 当 接收到 开启安卓脚本 信号时
	mainMenu.connect(MyConstant.SignalMethod.OPEN_MODULE_ANDROID_SCRIPT, open_module_android_script)
	# 监听信号, 当 接收到 开启文件脚本 信号时
	mainMenu.connect(MyConstant.SignalMethod.OPEN_MODULE_FILE_SCRIPT, open_module_file_script)
	pass
 
# splash 动画播放完毕之后的回调
func splashAnimatedFinish():
	print("splash 动画播放完毕了")
	pass

# 设置重命名
func dialog_set_rename():
	var dialog = preload("res://scene/dialog_set_rename.tscn").instantiate()
	add_child(dialog)
	pass
	
# 清理日志
func dialog_clear_system_log():
	var dialog = preload("res://scene/dialog_clear_system_log.tscn").instantiate()
	add_child(dialog)
	pass
	
# 设置当前的语言
func dialog_set_current_lanaguage():
	var dialog = preload("res://scene/dialog_set_current_lanaguage.tscn").instantiate()
	add_child(dialog)
	pass

# 退出程序信号
func dialog_exit_progress():
	var dialog = preload("res://scene/dialog_exit_progress.tscn").instantiate()
	add_child(dialog)
	pass

# 开启安卓脚本
func open_module_android_script():
	print("开启安卓脚本")
	pass

# 开启文件脚本
func open_module_file_script():
	print("开启文件脚本")
	# 如果当前侧边场景存在, 则移除当前场景
	if current_scene_mode:
		current_scene_mode.queue_free()
	# 创建当前的场景
	current_scene_mode = load("res://scene/model_file.tscn").instantiate()
	# 设置当前场景的名称 (用于后续信号查找到指定的场景信息)
	current_scene_mode.name = MyConstant.NodeName.MODEL_FILE
	# 添加场景到主场景中
	add_child(current_scene_mode)
	# 关联与当前信号相关的信号
	current_scene_mode.connect(MyConstant.SignalMethod.DIALOG_SET_RENAME, dialog_set_rename)
	pass
