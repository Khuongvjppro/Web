/**
 * 
 */
package com.banthatlung.Dao.model;

import java.io.Serializable;

/**
 * 
 */
public class Account implements Serializable {
	private static final long serialVersionUID = 1L;
	private String id;
    private String username;
    private String pass;
    
    public Account() {
    	
    }
    
	public Account(String id, String username, String pass) {
		super();
		this.id = id;
		this.username = username;
		this.pass = pass;
	}

	public Account(String username, String password) {
		this.username = username;
		this.pass = password;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}

	@Override
	public String toString() {
		return "Account: " + this.id + ", username: "+ this.username + ", pass: " + this.pass;
	}

}
