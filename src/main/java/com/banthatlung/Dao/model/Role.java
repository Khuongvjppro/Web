/**
 * 
 */
package com.banthatlung.Dao.model;

import java.io.Serializable;

/**
 * 
 */
public class Role implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private String accountID;
	private int role; //0 la user, 1 la admin
	
	public Role() {
		
	}

	public Role(int id, String account_id, int role) {
		super();
		this.id = id;
		this.accountID = account_id;
		this.role = role;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getAccount_id() {
		return accountID;
	}

	public void setAccount_id(String account_id) {
		this.accountID = account_id;
	}

	public int getRole() {
		return role;
	}

	public void setRole(int role) {
		this.role = role;
	}

	@Override
	public String toString() {
		String role = "user";
		if (this.role == 1) {
			role = "admin";
		}
		return "AccountID: " +this.accountID + ", Role: " + role;
	}
	
}
