package com.jkk.utils;

import java.io.InputStream;
import java.sql.*;
import java.util.*;

public class DButil {
	private String[] connAttr = new String[4];
	private Connection conn = null;
	private void readConfigFile(){
		Properties props = new Properties();
		try {
			InputStream infile = this.getClass().getResourceAsStream("/DB.properties");
			props.load(infile);

			connAttr[0] = props.getProperty("driver");
			connAttr[1] = props.getProperty("url");
			connAttr[2] = props.getProperty("username");
			connAttr[3] = props.getProperty("password");
		} catch (Exception e){
			e.printStackTrace();
		}
	}
	public DButil(){
		readConfigFile();
		try {
			Class.forName(connAttr[0]);
			conn = getConn(); //测试是否可以连接
			conn.close();
		} catch (Exception e){
			e.printStackTrace();
		}
	}

	/**
	 * 查找数据
	 * @param sql 预编译的sql指令
	 * @param param 替换sql的参数 无写 null
	 * @return 返回结果list 遇null则返回null
	 */
	public List<String[]> exePresqlSelect(String sql, Object[] param){
		List<String[]> res = new ArrayList<>();
		try {
			conn = getConn();
			PreparedStatement preSmt = conn.prepareStatement(sql);
			if (param != null) {
				for (int i=0; i<param.length; ++i){
					preSmt.setObject(i+1,param[i]);
				}
			}
			res = getDataFromRS(preSmt.executeQuery());
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			return res;
		}
	}
	public List<Map<String,String>> exePresqlGetmap(String sql, Object[] param){
		List<Map<String,String>> res = new ArrayList<>();
		try {
			conn = getConn();
			PreparedStatement preSmt = conn.prepareStatement(sql);
			if (param != null) {
				for (int i=0; i<param.length; ++i){
					preSmt.setObject(i+1,param[i]);
				}
			}
			ResultSet rs = preSmt.executeQuery();
			ResultSetMetaData rsmd = rs.getMetaData();
			while (rs.next()) {
				Map<String,String> map = new HashMap<>();
				for (int i=1; i<=rsmd.getColumnCount(); ++i) {
					map.put(rsmd.getColumnName(i),rs.getString(i));
				}
				res.add(map);
			}
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			return res;
		}
	}
	/**
	 * 给定conn的查询
	 * @param sql
	 * @param param
	 * @param conn
	 * @return
	 */
	public List<String[]> exePresqlSelect(String sql, Object[] param,Connection conn){
		List<String[]> res = new ArrayList<>();
		try {
			PreparedStatement preSmt = conn.prepareStatement(sql);
			if (param != null) {
				for (int i=0; i<param.length; ++i){
					preSmt.setObject(i+1,param[i]);
				}
			}
			res = getDataFromRS(preSmt.executeQuery());
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			return res;
		}

	}
	/**
	 * 查询指定条件在数据库中是否存在数据
	 * @param sql
	 * @param param
	 * @return
	 */
	public Boolean hasData(String sql, String[] param){
		List<String[]> list = exePresqlSelect(sql, param);
		return !list.isEmpty();
	}

	/**
	 * 增删改 对数据不要求返回的操作
	 * @param sql
	 * @param param
	 * @return 改sql影响的数据条数
	 */
	public int exePresqlModifyData(String sql, Object[] param){
		int modifyNum = 0;
		try {
			conn = getConn();
			PreparedStatement preSmt = conn.prepareStatement(sql);
			if (param != null) {
				for (int i=0; i<param.length; ++i){
					preSmt.setObject(i+1,param[i]);
				}
			}
			modifyNum = preSmt.executeUpdate();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			return modifyNum;
		}
	}

	/**
	 * 添加数据并获取自增长ID
	 * @param sql
	 * @param param
	 * @return
	 */
	public int addDataGetIncrement(String sql, Object[] param){
		int id = -1;
		try {
			conn = getConn();
			PreparedStatement preSmt = conn.prepareStatement(sql);
			if (param != null) {
				for (int i=0; i<param.length; ++i){
					preSmt.setObject(i+1,param[i]);
				}
			}
			preSmt.executeUpdate();
			id = Integer.parseInt(exePresqlSelect("SELECT LAST_INSERT_ID()",null,conn).get(0)[0]);

			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			return id;
		}
	}
	/**
	 * 构造函数可能触发异常 其他调用保证一定不会触发异常
	 * @return
	 */
	private Connection getConn(){
		Connection conn = null;
		try {
			conn = DriverManager.getConnection(connAttr[1], connAttr[2], connAttr[3]);
		}catch (Exception e){
			e.printStackTrace();
		} finally {
			return conn;
		}
	}
	private List<String[]> getDataFromRS(ResultSet rs) throws Exception{
		int field = rs.getMetaData().getColumnCount();
		List<String[]> res = new ArrayList<>();
		while (rs.next()) {
			String [] str = new String[field];
			for (int i=1; i<=field; ++i) {
				str[i-1] = rs.getString(i);
			}
			res.add(str);
		}
		return res;
	}

	public static void main(String[] args) {
		DButil dButil = new DButil();
		Map<String,String> map = dButil.exePresqlGetmap("SELECT id FROM user where name= 'admin' LIMIT 1",null).get(0);
		System.out.print(map);

	}
}
