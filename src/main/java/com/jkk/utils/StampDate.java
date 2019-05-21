package com.jkk.utils;

import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 十位时间戳与日期相互转化
 *
 * @author jkkwjk
 * @version : 2019/04/27 下午10:46
 */
public class StampDate {
	/*
	UPDATE user_file_folder set file_time = FROM_UNIXTIME(1554646875,'%Y-%m-%d %H:%m:%s') where id = 4
	 */
	public static void main(String[] args) {
		String s = "2019-04-07 22:01:30";
		long time = new Date().getTime();
		System.out.print(stampToDate("1554646875"));
	}
	public static String stampToDate(Long time){
		String result = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date(time*1000));
		return result;
	}
	public static String stampToDate(String time){
		return stampToDate(Long.valueOf(time));
	}
	public static String dateToStamp(Long date){
		return dateToStamp(date.toString());
	}
	public static String dateToStamp(String date){
		Long time = (new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).parse
				(date, new ParsePosition(0)).getTime()/1000;
		return time.toString();
	}
}
