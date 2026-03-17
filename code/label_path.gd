extends Label
   
@export var scroll_duration : float = 20.0   
@export var loop : bool = true   
@export var ease_type : Tween.EaseType = Tween.EASE_IN_OUT   
@export var trans_type: Tween.TransitionType = Tween.TRANS_SINE
   
var tween : Tween   
var label_width: float   
var is_scrolling: bool = false
   
func _ready() -> void:
	# 获取屏幕宽度
	label_width = get_viewport_rect().size.x 
	# 初始位置在屏幕右侧外
	position.x = label_width
	# 开始滚动
	start_scroll()
   
func start_scroll():
	# 清理之前的动画
	if tween:
		tween.kill()
		tween = null
	# 创建新的动画
	tween = create_tween()
	tween.set_ease(ease_type)
	tween.set_trans(trans_type)
	if loop:
		# 无限循环模式
		tween.set_loops(0)  # 0表示无限循环
		# 创建完整的滚动动画序列
		tween.tween_property(self, "position:x", -size.x, scroll_duration)
		tween.tween_callback(_on_loop_complete)
	else:
		# 单次模式
		tween.tween_property(self, "position:x", -size.x, scroll_duration)
	is_scrolling = true
   
func _on_loop_complete():
	# 当一轮滚动完成时，立即重置位置并开始下一轮
	position.x = label_width
	# 重要：这里不需要再创建动画，因为set_loops(0)会自动重复
	# 但需要确保动画正确配置
	if tween and is_scrolling:
		# 如果动画停止了，重新开始
		if not tween.is_running():
			tween.play()
   
# 更优雅的循环实现方式（替代方案）   
func start_scroll_alternative():
	if tween:
		tween.kill()
	tween = create_tween()
	tween.set_ease(ease_type)
	tween.set_trans(trans_type)
	# 方法1：使用链式动画（推荐）
	if loop:
		# 创建动画链
		tween.set_loops(0)
		# 第一步：从右侧滚动到左侧
		tween.tween_property(self, "position:x", -size.x, scroll_duration)
		# 第二步：瞬间重置位置（使用0秒动画）
		tween.tween_property(self, "position:x", label_width, 0)
	
# 方法2：使用回调+延迟（更灵活）
func start_scroll_with_delay():
	if tween:
		tween.kill()
	tween = create_tween()
		
func _create_scroll_sequence():
	# 重置位置
	position.x = label_width
	# 创建滚动动画
	tween.tween_property(self, "position:x", -size.x, scroll_duration)
	tween.tween_callback(_create_scroll_sequence).set_delay(0)  # 立即开始下一轮
	if loop:
		_create_scroll_sequence()
   
# 控制方法 暂停滚动   
func pause_scroll():
	if tween and tween.is_running():
		tween.pause()
	is_scrolling = false
   
# 控制方法 恢复滚动   
func resume_scroll():
	if tween and not tween.is_running():
		tween.play()
	is_scrolling = true
   
# 控制方法 停止滚动   
func stop_scroll():
	if tween:
		tween.kill()
		tween = null
	is_scrolling = false
   
# 设置滚动的速度   
func set_scroll_speed(new_speed: float):
	# 根据速度和文本长度计算持续时间
	scroll_duration = size.x / max(new_speed, 0.1)  # 防止除零
	
	if tween:
		# 重新开始动画以应用新的持续时间
		stop_scroll()
		start_scroll()        
