extends Node2D

@onready var splash		:Node = $Splash
@onready var mainMenu	:Node = $MainMenu

var current_scene_menu_left : Node
var current_scene_screen_all : Node

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
	# 监听信号, 当 接收到 关于版本 信号时
	mainMenu.connect(MyConstant.SignalMethod.OPEN_SHOW_ABOUT_VERSION, open_show_about_version)
	# 监听信号, 当 接收到 联系作者 信号时
	mainMenu.connect(MyConstant.SignalMethod.OPEN_SHOW_CONTACT_AUTHOR, open_show_contact_author)
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
	# 如果全屏场景存在, 则移除全屏场景
	if current_scene_screen_all:
		current_scene_screen_all.queue_free()
	# 如果当前侧边场景存在, 则移除当前场景
	if current_scene_menu_left:
		current_scene_menu_left.queue_free()
	# 创建当前的场景
	current_scene_menu_left = load("res://scene/mode_android.tscn").instantiate()
	# 设置当前场景的名称 (用于后续信号查找到指定的场景信息)
	current_scene_menu_left.name = MyConstant.NodeName.MODEL_ANDROID
	# 添加场景到主场景中
	add_child(current_scene_menu_left)
	pass

# 开启文件脚本
func open_module_file_script():
	print("开启文件脚本")
	# 如果全屏场景存在, 则移除全屏场景
	if current_scene_screen_all:
		current_scene_screen_all.queue_free()
	# 如果当前侧边场景存在, 则移除当前场景
	if current_scene_menu_left:
		current_scene_menu_left.queue_free()
	# 创建当前的场景
	current_scene_menu_left = load("res://scene/model_file.tscn").instantiate()
	# 设置当前场景的名称 (用于后续信号查找到指定的场景信息)
	current_scene_menu_left.name = MyConstant.NodeName.MODEL_FILE
	# 添加场景到主场景中
	add_child(current_scene_menu_left)
	# 关联与当前信号相关的信号
	current_scene_menu_left.connect(MyConstant.SignalMethod.DIALOG_SET_RENAME, dialog_set_rename)
	pass

# 开启关于版本脚本
func open_show_about_version():
	print("开启关于版本脚本")
	# 如果当前侧边场景存在, 则移除当前场景
	if current_scene_screen_all:
		current_scene_screen_all.queue_free()
	# 创建当前的场景
	current_scene_screen_all = load("res://scene/about_version.tscn").instantiate()
	# 设置当前场景的名称 (用于后续信号查找到指定的场景信息)
	current_scene_screen_all.name = MyConstant.NodeName.ABOUT_VERSION
	# 添加场景到主场景中
	add_child(current_scene_screen_all)
	pass

# 开启联系作者脚本
func open_show_contact_author():
	print("开启联系作者脚本")
	# 如果当前侧边场景存在, 则移除当前场景
	if current_scene_screen_all:
		current_scene_screen_all.queue_free()
	# 创建当前的场景
	current_scene_screen_all = load("res://scene/about_author.tscn").instantiate()
	# 设置当前场景的名称 (用于后续信号查找到指定的场景信息)
	current_scene_screen_all.name = MyConstant.NodeName.ABOUT_VERSION
	# 添加场景到主场景中
	add_child(current_scene_screen_all)
	pass
