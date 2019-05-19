package com.jkk.service.inter.Tools;

import java.util.Map;

public interface ValcodeBiz {
	Map<String,Object> getValcode();

	Boolean checkValcodeFromMap(String userCode,Map<String,Object> codeMap);
}
