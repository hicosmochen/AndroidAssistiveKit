extends Node2D

@onready var control_label: RichTextLabel = $Panel/RichTextLabel

var builder = PackedStringArray()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_scorll_style()
	# 监听信号
	add_to_group("show_control")
	pass # Replace with function body.

# 显示内容
func show_control(message: String):
	builder.append(current_time())
	builder.append(" ")
	builder.append(message)
	builder.append("\n")
	control_label.text = "".join(builder)
	pass

# 清理内容
func clear_control():
	builder.clear()
	control_label.text = ""
	pass

func current_time() -> String:
	var timeBuilder = PackedStringArray()
	var dic = Time.get_datetime_dict_from_system(true)
	var year = dic.get("year")
	var month = dic.get("month")
	var day = dic.get("day")
	var hour = dic.get("hour")
	var minute = dic.get("minute")
	var second = dic.get("second")
	timeBuilder.append(str(year))
	if month>9:
		timeBuilder.append(month)
	else:
		timeBuilder.append("0")
		timeBuilder.append(str(month))
	if day>9:
		timeBuilder.append(str(day))
	else:
		timeBuilder.append("0")
		timeBuilder.append(str(day))
	# 处理时差问题
	if hour < 16:
		hour = hour + 8
	else:
		hour = hour - 16
	# 处理小时数据
	if hour>9:
		timeBuilder.append("_")
		timeBuilder.append(str(hour))
	else:
		timeBuilder.append("_")
		timeBuilder.append("0")
		timeBuilder.append(str(hour))
	if minute>9:
		timeBuilder.append(str(minute))
	else:
		timeBuilder.append("0")
		timeBuilder.append(str(minute))
	if second>9:
		timeBuilder.append(str(second))
	else:
		timeBuilder.append("0")
		timeBuilder.append(str(second))
	return "".join(timeBuilder)
	

func set_scorll_style():
	# 在脚本中创建主题并应用到 RichTextLabel   
	var theme = Theme.new()
	# 创建样式   
	var vscroll_style = StyleBoxFlat.new()
	vscroll_style.bg_color = Color(0.2, 0.2, 0.2)  # 滚动条背景色   
	vscroll_style.border_width_bottom = 10
	vscroll_style.border_width_top = 10
	vscroll_style.border_width_left = 10
	vscroll_style.border_width_right = 10
	
	vscroll_style.corner_radius_top_left = 10
	vscroll_style.corner_radius_top_right = 10
	vscroll_style.corner_radius_bottom_left = 10
	vscroll_style.corner_radius_bottom_right = 10
	vscroll_style.border_color = Color(0.4, 0.4, 0.4, 0.02)
	   
	var vscroll_grabber = StyleBoxFlat.new()
	vscroll_grabber.bg_color = Color(0.317, 0.645, 0.749, 1.0)  # 滑块颜色
	vscroll_grabber.corner_radius_top_left = 10
	vscroll_grabber.corner_radius_top_right = 10
	vscroll_grabber.corner_radius_bottom_left = 10
	vscroll_grabber.corner_radius_bottom_right = 10
 
	# 应用到主题   
	theme.set_stylebox("scroll", "VScrollBar", vscroll_style)   
	theme.set_stylebox("grabber", "VScrollBar", vscroll_grabber)   
	theme.set_stylebox("grabber_highlight", "VScrollBar", vscroll_grabber)   
	theme.set_stylebox("grabber_pressed", "VScrollBar", vscroll_grabber)
	   
	# 应用到 RichTextLabel   
	control_label.theme = theme
	pass
