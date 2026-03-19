extends Node

# 获取字符串
func getString(key: String) -> String:
	# 设置当前的语言环境
	var current_language = MyUtil.get_data(MyConstant.SettingKey.CURRENT_LANGUAGE)
	if current_language.is_empty():
		current_language = MyConstant.LanguageType.ZH
	# 返回需要显示的结果
	var result = _load_current_lanague(current_language, key)
	return result


# 根据语言和指定的键, 返回结果
func _load_current_lanague(language: String, key: String) -> String:
	var object
	match  language:
		MyConstant.LanguageType.EN:
			object = MyLanague.EN.new().get(key)
		MyConstant.LanguageType.ZH:
			object = MyLanague.ZH.new().get(key)
	return str(object)
