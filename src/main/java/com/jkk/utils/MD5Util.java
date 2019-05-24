package com.jkk.utils;

import org.apache.commons.codec.digest.DigestUtils;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

public class MD5Util {
	public static String md5(String pwd) {
		return DigestUtils.md5Hex(pwd);
	}
	public static String md5two(String pwd) {
		return md5(md5(pwd));
	}
	public static void main(String[] args) {
		System.out.print(DigestUtils.md5Hex(DigestUtils.md5Hex("admin123")));
	}

	public static String getInputMD5(InputStream input) throws IOException {
		return DigestUtils.md5Hex(StreamWithOther.input2Byte(input));
	}

}
