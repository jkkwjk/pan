package com.jkk.utils;

import java.math.BigDecimal;

public class FilesizeUtil {
	private static final String[] unit = new String[]{"B","KB","MB","GB","TB"};

	/**
	 * B到其他的单位转化
	 * @param fileSizeb B中的数字 可以带B或b
	 * @return 返回其他单位的字符串 带单位
	 */
	public static String BToOther(String fileSizeb) {
		StringBuffer str = new StringBuffer(fileSizeb);
		if (str.charAt(str.length()-1)=='b' || str.charAt(str.length()-1)=='B'){
			str = str.deleteCharAt(str.length()-1);
		}
		BigDecimal bigDecimal = new BigDecimal(str.toString());
		int unitSize = 0;
		while (bigDecimal.doubleValue()>1024) {
			bigDecimal = bigDecimal.divide(new BigDecimal("1024"));
			++unitSize;
		}
		return bigDecimal.setScale(2,BigDecimal.ROUND_HALF_UP).toString()+ unit[unitSize];
	}

	/**
	 * 其他单位到B的转化
	 * @param otherSize 其他单位 必须带上单位
	 * @return 不带B
	 */
	public static String OtherToB(String otherSize) {
		StringBuffer str = new StringBuffer(otherSize.toUpperCase());
		int unitSize = 0;
		if (str.charAt(str.length()-1)=='b' || str.charAt(str.length()-1)=='B'){
			str = str.deleteCharAt(str.length()-1);
		}
		char lastch = str.charAt(str.length()-1);
		if (!(lastch>'0' && lastch<'9')) {

			for (int i=1; i<unit.length; ++i) {
				if (unit[i].length()!=1) {
					if (unit[i].charAt(0) == lastch){
						unitSize=i;
					}
				}
			}
			str = str.deleteCharAt(str.length()-1);
		}
		// 到此只剩下数字
		BigDecimal result = new BigDecimal(str.toString());
		result = result.multiply(new BigDecimal(String.valueOf(Math.pow(1024,unitSize))));
		return result.setScale(0,BigDecimal.ROUND_HALF_UP).toString()+'b';


	}
	public static void main(String[] args) {
		System.out.print(OtherToB("1gb"));
	}
}
