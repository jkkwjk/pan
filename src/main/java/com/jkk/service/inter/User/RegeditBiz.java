package com.jkk.service.inter.User;

import java.util.Map;

public interface RegeditBiz {
	Boolean checkUsernameIsstrong(String userName);

	Boolean checkUsernameIsSame(String userName);

	Boolean checkPwdIsstrong(String pwd);

	Map<String,Object> getValcode();

	Boolean checkValcode(String userCode,Map<String,Object> codeMap);

	Boolean addUser(String userName,String pwd);
}
