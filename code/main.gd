extends Node2D

@onready var splash		:Node = $Splash
@onready var mainMenu	:Node = $MainMenu
@onready var modelFile	:Node = $ModelFile

func _ready() -> void:
	# 监听信号, 当 splash 动画播放完毕之后的处理
	splash.connect("splashAnimatedFinish", splashAnimatedFinish)
	# 监听信号, 当 接收到退出程序的信号时
	mainMenu.connect("exitProgress", exitProgress)
	# 监听信号, 当 接收到重命名的信号时
	modelFile.connect("setRename", setRename)
	pass
 
# splash 动画播放完毕之后的回调
func splashAnimatedFinish():
	print("splash 动画播放完毕了")
	pass

# 设置重命名
func setRename():
	var dialog = preload("res://scene/set_rename.tscn").instantiate()
	add_child(dialog)
	pass

# 退出程序信号
func exitProgress():
	var dialog = preload("res://scene/exit_progress.tscn").instantiate()
	add_child(dialog)
	pass
