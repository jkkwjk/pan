package com.jkk.service.inter.Disk;

import org.apache.commons.fileupload.FileItem;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import java.util.Map;

public interface FileIOup {
	void writeFile(ServletContext context, String uploadDir, FileItem fileByte, String fileMD5) throws Exception;

	/**
	 * 需要保证 request 参数中不包含 __file__ 这个key
	 * @param request
	 * @return 返回request解析结果 如果有file项的话 其key = __file__
	 * @throws Exception
	 */
	Map<String,Object> parseRequest(HttpServletRequest request) throws Exception;
}
