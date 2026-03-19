extends Node2D

@onready var splash		:Node = $Splash
@onready var mainMenu	:Node = $MainMenu
@onready var modelFile	:Node = $ModelFile

func _ready() -> void:
	
	# 监听信号, 当 splash 动画播放完毕之后的处理
	splash.connect(MyConstant.SignalName.SPLASH_ANIMATED_FINISH, splashAnimatedFinish)
	# 监听信号, 当 接收到退出程序的信号时
	mainMenu.connect(MyConstant.SignalMethod.DIALOG_EXIT_PROGRESS, dialog_exit_progress)
	# 监听信号, 当 接收到清理日志的信号时
	mainMenu.connect(MyConstant.SignalMethod.DIALOG_CLEAR_SYSTEM_LOG, dialog_clear_system_log)
	# 监听信号, 当 接收到重命名的信号时
	modelFile.connect(MyConstant.SignalMethod.DIALOG_SET_RENAME, dialog_set_rename)
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

# 退出程序信号
func dialog_exit_progress():
	var dialog = preload("res://scene/dialog_exit_progress.tscn").instantiate()
	add_child(dialog)
	pass
