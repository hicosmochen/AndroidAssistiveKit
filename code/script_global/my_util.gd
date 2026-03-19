extends Node

# 工具方法, 存储设置数据
func set_data(key:String, value:String):
	ProjectSettings.set_setting(key, value)
	pass
	
# 工具方法, 获取设置数据
func get_data(key:String) -> String:
	var result = ProjectSettings.get_setting(key, "")
	return str(result)

# 重置按钮的状态, 延迟一帧之后, 执行释放焦点, 修改按下的状态
func resetButtonPressedStatus(button: Button):
	await  button.get_tree().process_frame
	button.release_focus()
	button.button_pressed = false
	pass

# 打开文件浏览器对话框 	file_dialog.dir_selected.connect(menthodName) # 连接信号  
func open_file_folder(defaultPath:String) -> FileDialog:
	# 创建 FileDialog   
	var file_dialog = FileDialog.new()
	file_dialog.file_mode = FileDialog.FILE_MODE_OPEN_DIR  # 设置为目录选择模式
	file_dialog.access = FileDialog.ACCESS_FILESYSTEM
	# 使用原生本地的对话框样式
	file_dialog.use_native_dialog = true
	# 如果未选择文件夹, 默认采用文件的路径, 如果选择了文件夹, 默认采用上一次的路径
	if defaultPath.is_empty():
		file_dialog.current_dir = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
	else:
		file_dialog.current_dir = defaultPath
	add_child(file_dialog)
	file_dialog.popup_centered(Vector2i(1280, 720))  # 弹出对话框
	return file_dialog

# 批量重命名核心函数   
func batch_rename(directory_path: String, prefix: String = "file_", digits: int = 4) -> void:
	# 获取目录中的所有文件
	var dir := DirAccess.open(directory_path)
	if not dir:
		sendMessageToArea((MyContext.getString(MyString.ERROR_UNABLE_TO_OPEN_DIRECTORY) + " %s") %[directory_path])
		return
	# 获取文件列表（排除自身）
	var files := []
	var script_name :String = get_script().get_path().get_file()
	dir.list_dir_begin()
	var file_name := dir.get_next()
	while file_name != "":
		if not dir.current_is_dir() and file_name != script_name:
			files.append(file_name)
		file_name = dir.get_next()
	dir.list_dir_end()
	if files.is_empty():
		sendMessageToArea(MyContext.getString(MyString.NO_FILES_IN_THE_DIRECTORY))
		return
	sendMessageToArea(MyContext.getString(MyString.START_RENAMING))
	print("------------------------------------------")
	var count := 1
	# 遍历并重命名文件
	for old_name in files:
		# 获取文件扩展名
		var extension :String= old_name.get_extension()
		if extension.length() > 0:
			extension = "." + extension
		# 生成序号字符串
		var num_str := str(count)
		while num_str.length() < digits:
			num_str = "0" + num_str
		# 构建新文件名
		var new_name :String= prefix + num_str + extension
		# 重命名文件
		var old_path := directory_path.path_join(old_name)
		var new_path := directory_path.path_join(new_name)
		var error := dir.rename(old_path, new_path)
		if error == OK:
			sendMessageToArea("%s  ->  %s" % [old_name, new_name])
			count += 1
		else:
			sendMessageToArea((MyContext.getString(MyString.ERROR_UNABLE_TO_RENAME) 
				+ " %s ("+MyContext.getString(MyString.ERROR_CODE)+" %d)") % [old_name, error])
	sendMessageToArea("------------------------------------------")
	sendMessageToArea(MyContext.getString(MyString.RENAMING_COMPLETE))
	sendMessageToArea((MyContext.getString(MyString.PROCESSED_IN_TOTAL) + " %d " + MyContext.getString(MyString.FILES) ) % (count - 1))
	pass
	
# 将字符串写入到文件中
func write_string_to_file(directory_path: String, file_name: String, message: String) -> void:
	# 使用协程的方式写入数据
	var path = directory_path + "//" + file_name
	await get_tree().process_frame
	var file = FileAccess.open(path, FileAccess.WRITE)
	if file != null:
		file.store_string(message)
		file.close()
		sendMessageToArea(MyContext.getString(MyString.OPERATION_SUCCESS))
	else:
		sendMessageToArea(MyContext.getString(MyString.OPERATION_FAILED))
	pass

# 发送信息给展示区域
func sendMessageToArea(message: String):
	# 直接向组里面发送数据
	get_tree().call_group(MyConstant.SignalName.SHOW_CONTROL, MyConstant.SignalMethod.SHOW_CONTROL,  message)
	pass

# 发送清理系统日志给展示区域
func clearMessageToArea():
	get_tree().call_group(MyConstant.SignalName.SHOW_CONTROL, MyConstant.SignalMethod.CLEAR_CONTROL)
	pass

# 缓存系统日志到文件中
func saveMessageToFile():
	# 直接向组里面发送数据
	get_tree().call_group(MyConstant.SignalName.SHOW_CONTROL, MyConstant.SignalMethod.SAVE_CONTROL)
	pass


# 将数组转换成为字符串类型
func forwardArrayToString(array : Array) -> String:
	var builder = PackedStringArray()
	for i in range(array.size()):
		builder.append(array[i])
	return "".join(builder)


# 执行adb命令的工具方法
# 备用方案：使用 Process 类（Godot 4.x）   
func execute_adb_command(array: Array) -> Dictionary:
	var output = []
	var exit_code = OS.execute("adb", PackedStringArray(array), output)
	return {
		"success": exit_code == 0,
		"exit_code": exit_code,
		"output": output
	}
