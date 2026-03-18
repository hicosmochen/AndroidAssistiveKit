extends Node

# 信号关联的方法
class SignalMethod:
	static var SPLASH_ANIMATED_FINISH 	: String = "splashAnimatedFinish"
	static var EXIT_PROGRESS 			: String = "exitProgress"
	static var SET_RENAME 				: String = "setRename"
	static var SHOW_CONTROL 				: String = "show_control"
	static var CLEAR_CONTROL				: String = "clear_control"
	
	static var GET_FILE_PARAM_PREFIX		: String = "getFileParamPrefix"
	static var GET_FILE_PARAM_DEIGITS	: String = "getFileParamDeigits"
	static var FILE_PREFIX_CHANGE 		: String = "filePrefixChange"
	static var FILE_DEIGITS_CHANGE 		: String = "fileDeigitsChange"
	static var FILE_PATH_CHANGE 			: String = "filePathChange"
	pass

# 信号关联的名称
class SignalName:
	static var SPLASH_ANIMATED_FINISH	: String = "splashAnimatedFinish"
	static var SHOW_CONTROL 				: String = "show_control"
	static var SHOW_FILE_PARAM			: String = "show_file_param"
	pass

# 节点路由
class NodeRoute:
	static var MODEL_FILE				: String = "/root/Main/ModelFile"
	pass

# 全局设置的建
class SettingKey:
	static var FILE_DIR_PATH				: String = "file_dir_path"
	pass
