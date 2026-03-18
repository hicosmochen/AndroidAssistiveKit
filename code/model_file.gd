extends Node2D

@onready var button_rename_set 	: Button = $Panel/Button_01
@onready var button_rename_start : Button = $Panel/Button_02 
@onready var button_operator_01 	: Button = $Panel/Button_03
@onready var button_operator_02 	: Button = $Panel/Button_04
@onready var button_operator_03 	: Button = $Panel/Button_05

signal setRename()

# 创建字典, 保存需要的数据
var fileParam = {
	"filePath" : "",
	"prefix": "file_",
	"deigits": 4
}

func _ready() -> void:
	# 监听信号
	add_to_group("show_file_param")
	# 设置按钮的点击事件
	button_rename_set.connect("button_down", clickButtonRenameSet)
	button_rename_start.connect("button_down", clickButtonRenameStart)
	pass

# 信号监听的回调方法, 用于修改 prefix 的数据值
func filePrefixChange(value: String):
	fileParam.set("prefix", value)
	pass

# 信号监听的回调方法, 用于修改 deigits 的数据值
func fileDeigitsChange(value: int):
	fileParam.set("deigits", value)
	pass

# 信号监听的回调方法, 用于修改 filePath 的数据值
func filePathChange(value: String):
	fileParam.set("filePath", value)
	pass

# 对外暴露方法, 暴露数据值
func getFileParamPrefix() -> String:
	return fileParam["prefix"]

# 对外暴露方法, 暴露数据值
func getFileParamDeigits() -> int:
	return fileParam["deigits"]

# 设置重命名
func clickButtonRenameSet():
	print("设置重命名...")
	emit_signal("setRename")
	pass

# 开始重命名
func clickButtonRenameStart():
	print("开始重命名...")
	# 获取字典数据
	var filePath = str(fileParam.get("filePath"))
	var prefix = str(fileParam.get("prefix"))
	var deigits = str(fileParam.get("deigits"))
	var workspacePath = MyUtil.get_data("file_dir_path")
	# 校验场景是否正确
	if filePath.is_empty():
		if workspacePath.is_empty():
			MyUtil.sendMessageToArea("路径不能为空")
			return
		else:
			filePath = workspacePath
	if filePath.is_empty():
		MyUtil.sendMessageToArea("路径不能为空")
	elif prefix.is_empty():
		MyUtil.sendMessageToArea("前缀不能为空")
	else:
		MyUtil.sendMessageToArea("进行批量重命名")
		MyUtil.batch_rename(filePath, prefix, int(deigits))
	pass
