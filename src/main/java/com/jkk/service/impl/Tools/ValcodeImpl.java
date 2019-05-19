package com.jkk.service.impl.Tools;

import com.jkk.service.inter.Tools.ValcodeBiz;
import com.jkk.tools.ValcodeTool;

import java.util.Map;

public class ValcodeImpl implements ValcodeBiz {
	@Override
	public Map<String, Object> getValcode() {
		return ValcodeTool.getValcode();
	}

	@Override
	public Boolean checkValcodeFromMap(String userCode, Map<String, Object> codeMap) {
		String codeText = (String) codeMap.get("code");
		return codeText.equals(userCode);
	}
}
