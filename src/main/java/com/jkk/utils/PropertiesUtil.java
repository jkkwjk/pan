package com.jkk.utils;

import java.io.FileInputStream;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

public class PropertiesUtil {
	private InputStream inputStream = null;
	private Properties props = new Properties();

	public PropertiesUtil(String path){
		String truePath = "";
		try {
			truePath = this.getClass().getResource(path).getPath();
		}catch (NullPointerException e){
			truePath = path;
		}finally {
			try {
				inputStream = new FileInputStream(truePath);
				props.load(inputStream);
			}catch (Exception e){
				e.printStackTrace();
			}

		}
	}

	public String getValue(String key) {
		return props.getProperty(key);
	}

	public Map<String,String> getAll(){
		Map<String,String> ret = new HashMap<>();
		for (String stringPropertyName : props.stringPropertyNames()) {
			ret.put(stringPropertyName,String.valueOf(props.get(stringPropertyName)));
		}
		return ret;
	}

	public Properties getProps(){
		return this.props;
	}
}
