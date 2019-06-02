package com.jkk.service.impl.Disk;


import com.jkk.service.inter.Disk.FileIOup;
import com.jkk.utils.MD5Util;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class FileIOupImpl extends FileIOBaseImpl implements FileIOup{
	private static final int MEMORY_LIMIT = 5*1024*1024;
	private static final int MAX_FILE_SIZE = 100*1024*1024;
	private static final int MAX_REQUEST_SIZE = 120*1024*1024; //请求大小 防止恶意提交
	private ServletFileUpload upload;
	public FileIOupImpl(){
		DiskFileItemFactory factory = new DiskFileItemFactory();

		factory.setSizeThreshold(MEMORY_LIMIT); //内存限制
		factory.setRepository(new File(System.getProperty("java.io.tmpdir")));
		upload = new ServletFileUpload(factory);

		upload.setFileSizeMax(MAX_FILE_SIZE);
		upload.setSizeMax(MAX_REQUEST_SIZE);
	}
	public FileIOupImpl(int maxSize){
		DiskFileItemFactory factory = new DiskFileItemFactory();

		factory.setSizeThreshold(MEMORY_LIMIT); //内存限制
		factory.setRepository(new File(System.getProperty("java.io.tmpdir")));
		upload = new ServletFileUpload(factory);

		upload.setFileSizeMax(maxSize);
		upload.setSizeMax(maxSize+3*1024*1024);
	}
	@Override
	public void writeFile(ServletContext context, String folderPath, FileItem fileByte, String fileMD5) throws Exception{
		String upPath = super.getBasePath(context)+folderPath;
		File existF = new File(upPath);
		if (!existF.exists()){existF.mkdir();}


		String filePath = upPath + File.separator + fileMD5;
		File storeFile = new File(filePath);// 真正要写入的文件
		fileByte.write(storeFile);
	}

	@Override
	public void writeFile(String path, FileItem fileByte,String fileName) throws Exception{

		File existF = new File(path);
		if (!existF.exists()){existF.mkdir();}

		String filePath = path + File.separator + fileName;
		File storeFile = new File(filePath);
		if (!storeFile.exists()){fileByte.write(storeFile);}
	}

	@Override
	public Map<String, Object> parseRequest(HttpServletRequest request) throws FileUploadException, UnsupportedEncodingException {
		List<FileItem> formItems = upload.parseRequest(request);
		Map<String,Object> obj = new HashMap<>();

		if (formItems != null && formItems.size()>0){
			for (FileItem item : formItems) {
				if (item.isFormField()) {
					//普通表单
					obj.put(item.getFieldName(),item.getString("utf8"));
				}else {
					//文件
					obj.put("__file__",item);
				}
			}
		}

		return obj;
	}
}
