package com.jkk.tools;

import org.apache.commons.codec.digest.DigestUtils;

public class MD5Tool {
	public static String md5(String pwd) {
		return DigestUtils.md5Hex(pwd);
	}
	public static String md5two(String pwd) {
		return md5(md5(pwd));
	}
	public static void main(String[] args) {
		System.out.print(DigestUtils.md5Hex(DigestUtils.md5Hex("admin123")));
	}
}
