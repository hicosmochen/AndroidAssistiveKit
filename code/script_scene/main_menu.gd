extends Node2D

@onready var currentPathLabel = $ColorRect/Label_path

var MENU_GROUP_SETTING_PATH 		: int = 1001
var MENU_GROUP_SETTING_CLEAR 		: int = 1002
var MENU_GROUP_SETTING_EXIT 		: int = 1003
var MENU_GROUP_MODULE_ANDROID 		: int = 2001
var MENU_GROUP_MODULE_FILE 			: int = 2002
var MENU_GROUP_ABOUT_VERSION 		: int = 3001
var MENU_GROUP_ABOUT_DOCUMENT 		: int = 3002
var MENU_GROUP_ABOUT_AUTHOR 		: int = 3003

# 定义信号
signal dialog_exit_progress()
signal dialog_clear_system_log()

# 使用字典映射处理函数   
var menu_handlers = {   
	MENU_GROUP_SETTING_PATH			: "_open_work_path_dialog", 
	MENU_GROUP_SETTING_CLEAR		: "_clear_system_log",  
	MENU_GROUP_SETTING_EXIT			: "_quit_application",   
	MENU_GROUP_MODULE_ANDROID		: "_open_android_script_module",   
	MENU_GROUP_MODULE_FILE			: "_open_file_script_module",   
	MENU_GROUP_ABOUT_VERSION		: "_show_version_info",   
	MENU_GROUP_ABOUT_DOCUMENT		: "_open_help_document",   
	MENU_GROUP_ABOUT_AUTHOR			: "_contact_author"   
}

func _ready() -> void:
	# 创建菜单
	create_menu()
	pass

# 创建菜单
func create_menu():
	# 创建主菜单 设置
	var menu_main_setting = MenuButton.new()
	menu_main_setting.text = MyContext.getString(MyString.SETTING)
	menu_main_setting.position = Vector2(0, 0)
	
	# 添加主菜单 设置的子选项菜单 MyString.WORK_SPACE
	var menu_group_setting = menu_main_setting.get_popup()
	menu_group_setting.add_item(MyContext.getString(MyString.WORK_SPACE), MENU_GROUP_SETTING_PATH)
	menu_group_setting.add_item(MyContext.getString(MyString.CLEAR_LOG), MENU_GROUP_SETTING_CLEAR)
	menu_group_setting.add_item(MyContext.getString(MyString.EXIT), MENU_GROUP_SETTING_EXIT)
	
	# 创建主菜单 模块
	var menu_main_module = MenuButton.new()
	menu_main_module.text = MyContext.getString(MyString.MODEL)
	menu_main_module.position = Vector2(150, 0)
	
	# 添加主菜单 模块的子选项菜单
	var menu_group_module = menu_main_module.get_popup()
	menu_group_module.add_item(MyContext.getString(MyString.ANDROID_SCRIPT), MENU_GROUP_MODULE_ANDROID)
	menu_group_module.add_item(MyContext.getString(MyString.FILE_SCRIPT), MENU_GROUP_MODULE_FILE)
	
	# 创建主菜单 模块
	var menu_main_about = MenuButton.new()
	menu_main_about.text = MyContext.getString(MyString.ABOUT)
	menu_main_about.position = Vector2(300, 0)

	# 添加主菜单 模块的子选项菜单
	var menu_group_about = menu_main_about.get_popup()
	menu_group_about.add_item(MyContext.getString(MyString.SOFTWARE_VERSION), MENU_GROUP_ABOUT_VERSION)
	menu_group_about.add_item(MyContext.getString(MyString.HELP_DOCUMENTATION), MENU_GROUP_ABOUT_DOCUMENT)
	menu_group_about.add_item(MyContext.getString(MyString.CONTACT_THE_AUTHOR), MENU_GROUP_ABOUT_AUTHOR)
	
	add_child(menu_main_setting)
	add_child(menu_main_module)
	add_child(menu_main_about)
	
	# 创建自定义主题
	var theme = preload("res://theme/menu_popup.tres")
	# 应用主题
	menu_main_setting.theme = theme
	menu_main_module.theme = theme
	menu_main_about.theme = theme
	
	menu_group_setting.theme = theme
	menu_group_module.theme = theme
	menu_group_about.theme = theme
	
	# 创建popup组
	var popups = [menu_group_setting, menu_group_module, menu_group_about]
	for popup in popups:
		popup.id_pressed.connect(clickGroupMenu)
	pass

# 统一处理菜单组的点击事件
func clickGroupMenu(id: int):
	if menu_handlers.has(id):
		var method_name = menu_handlers[id]
		if  has_method(method_name):
			call(method_name)
		else:
			print("未找到对应ID处理函数: ", id)
	pass



# 菜单的点击事件 
func _open_work_path_dialog():
	print("选择工作路径..")
	var dirPath = MyUtil.get_data(MyConstant.SettingKey.FILE_DIR_PATH)
	# 打开路径
	var fileDialog = MyUtil.open_file_folder(dirPath)
	# 关联信号
	fileDialog.dir_selected.connect(dir_selected)
	
	pass

# 选择的文件路径
func dir_selected(path: String):
	print("当前选择的路径: " , path)
	MyUtil.set_data(MyConstant.SettingKey.FILE_DIR_PATH, path)
	MyUtil.sendMessageToArea(MyContext.getString(MyString.CURRENT_WORK_SPACE) + path)
	# 需要修改底部的路径地址
	currentPathLabel.text = MyContext.getString(MyString.CURRENT_WORK_SPACE) + path
	pass

# 清理系统日志
func _clear_system_log():
	print("清理系统日志")
	emit_signal("dialog_clear_system_log")
	pass

# 菜单的点击事件 
func _quit_application():
	print("退出程序..")
	emit_signal("dialog_exit_progress")
	pass
	
# 菜单的点击事件 
func _open_android_script_module():
	print("开启安卓脚本..")
	pass
	
# 菜单的点击事件 
func _open_file_script_module():
	print("开启文件脚本..")
	pass
	
# 菜单的点击事件 
func _show_version_info():
	print("显示版本信息..")
	pass
	
# 菜单的点击事件 
func _open_help_document():
	print("打开帮助文档..")
	pass
	
# 菜单的点击事件 
func _contact_author():
	print("联系作者..")
	pass
