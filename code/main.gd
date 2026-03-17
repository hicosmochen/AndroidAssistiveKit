extends Node2D

@onready var splash:Node = $Splash

func _ready() -> void:
	# 监听信号, 当 splash 动画播放完毕之后的处理
	splash.connect("splashAnimatedFinish", splashAnimatedFinish)
	
	pass
 
# splash 动画播放完毕之后的回调
func splashAnimatedFinish():
	print("splash 动画播放完毕了")
	pass
