extends Node

# 信号关联的方法
class SignalMethod:
	static var SPLASH_ANIMATED_FINISH 				: String = "splashAnimatedFinish"
	static var SHOW_CONTROL 						: String = "show_control"
	static var CLEAR_CONTROL						: String = "clear_control"
	static var SAVE_CONTROL							: String = "save_control"
	
	static var DIALOG_EXIT_PROGRESS 				: String = "dialog_exit_progress"
	static var DIALOG_SET_RENAME 					: String = "dialog_set_rename"
	static var DIALOG_CLEAR_SYSTEM_LOG				: String = "dialog_clear_system_log"
	static var DIALOG_SET_CURRENT_LANAGUAGE			: String = "dialog_set_current_lanaguage"
	
	static var OPEN_MODULE_ANDROID_SCRIPT			: String = "open_module_android_script"
	static var OPEN_MODULE_FILE_SCRIPT				: String = "open_module_file_script"
	
	static var OPEN_SHOW_ABOUT_VERSION				: String = "open_show_about_version"
	static var OPEN_SHOW_HELP_DOCUMENT				: String = "open_show_help_document"
	static var OPEN_SHOW_CONTACT_AUTHOR				: String = "open_show_contact_author"
	
	static var GET_FILE_PARAM_PREFIX				: String = "getFileParamPrefix"
	static var GET_FILE_PARAM_DEIGITS				: String = "getFileParamDeigits"
	static var FILE_PREFIX_CHANGE 					: String = "filePrefixChange"
	static var FILE_DEIGITS_CHANGE 					: String = "fileDeigitsChange"
	static var FILE_PATH_CHANGE 					: String = "filePathChange"
	pass

# 信号关联的名称
class SignalName:
	static var SPLASH_ANIMATED_FINISH				: String = "splashAnimatedFinish"
	static var SHOW_CONTROL 						: String = "show_control"
	static var SHOW_FILE_PARAM						: String = "show_file_param"
	pass

# 节点路由
class NodeRoute:
	static var MODEL_FILE							: String = "/root/Main/ModelFile"
	static var MODEL_ANDROID						: String = "/root/Main/ModelAndroid"
	pass

# 场景节点的名称
class NodeName:
	static var MODEL_FILE							: String = "ModelFile"
	static var MODEL_ANDROID						: String = "ModelAndroid"
	static var ABOUT_VERSION						: String = "AboutVersion"
	pass


# 全局设置的建
class SettingKey:
	static var FILE_DIR_PATH						: String = "file_dir_path"
	static var CURRENT_LANGUAGE						: String = "current_language"
	pass
	
# 语言类型
class LanguageType:
	static var ZH									: String = "zh"
	static var EN									: String = "en"
	pass
