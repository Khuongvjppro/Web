/**
 * 
 */
package com.banthatlung.Dao.model;

import java.io.Serializable;

/**
 * 
 */
public class Resource implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private String accountID;
	private int permission; //quyen tu 0 den 7 tu 3 quyen read(4), write(2), execute(1), -1 user bi ban

	public Resource() {
		
	}

	public Resource(int id, String accountID, int permission) {
		super();
		this.id = id;
		this.accountID = accountID;
		this.permission = permission;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getAccountID() {
		return accountID;
	}

	public void setAccountID(String accountID) {
		this.accountID = accountID;
	}

	public int getPermission() {
		return permission;
	}

	public void setPermission(int permission) {
		this.permission = permission;
	}

	@Override
	public String toString() {
		String p = "none";
		switch (this.getPermission()) {
		case -1:
			p = "banned"; break;
		case 1:
			p = "execute"; break;
		case 2:
			p = "write"; break;
		case 3:
			p = "execute and write"; break;
		case 4:
			p = "read"; break;
		case 5:
			p = "read and execute"; break;
		case 6:
			p = "read and write"; break;
		case 7:
			p = "read, write and execute"; break;
		} 
		return "AccountID: " + this.accountID + ", permission: " + p;
	}
}
