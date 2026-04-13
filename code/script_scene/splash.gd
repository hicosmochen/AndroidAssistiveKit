extends Node2D

@onready var splashAnimatedSprite2D: AnimatedSprite2D = $Splash_AnimatedSprite2D

# 定义信号, 表示 splash 动画播放完毕
signal splashAnimatedFinish()


func _ready() -> void:
	# 播放 splash 动画
	playSplashAnimated()
	pass

func playSplashAnimated():
	# 播放动画
	splashAnimatedSprite2D.play("default")
	# 等待几秒钟
	await get_tree().create_timer(2.0).timeout
	splashAnimatedSprite2D.stop()
	# 发射信号
	emit_signal("splashAnimatedFinish")
	# 退出当前的场景
	queue_free()
	pass
