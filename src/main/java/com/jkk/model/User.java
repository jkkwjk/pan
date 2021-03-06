package com.jkk.model;

public class User {
	private int userId;
	private String name;
	private int permissionId;

	public User(int userId, String name, int permissionId) {
		this.userId = userId;
		this.name = name;
		this.permissionId = permissionId;
	}

	public User() {
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getPermissionId() {
		return permissionId;
	}

	public void setPermissionId(int permissionId) {
		this.permissionId = permissionId;
	}
}
