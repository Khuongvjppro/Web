package com.banthatlung.Dao.model;

import java.io.Serializable;
import java.sql.Date;

public class User implements Serializable {
    private static final long serialVersionUID = 1L;
	private int id;
	private String accountID;
    private String name;
    private String email;
    private String phone;
    private Date birthday;
    private String gender;
    private String image;

    public int getId() {
        return id;
    }

    public User(){

    }

	public User(int id, String accountID, String name, String email, String phone, Date birthday, String gender,
			String image) {
		super();
		this.id = id;
		this.accountID = accountID;
		this.name = name;
		this.email = email;
		this.phone = phone;
		this.birthday = birthday;
		this.gender = gender;
		this.image = image;
	}

	public User(int id, String accountID, String name, String email, String phone) {
		super();
		this.id = id;
		this.accountID = accountID;
		this.name = name;
		this.email = email;
		this.phone = phone;
	}

	public String getAccountID() {
		return accountID;
	}

	public void setAccountID(String accountID) {
		this.accountID = accountID;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public void setId(int id) {
		this.id = id;
	}

	@Override
	public String toString() {
		return "Name: " + this.name + ", gender: " + this.gender + ", birthday: " + this.birthday + "\n" +
				"Email: " + this.email + ", Phone: " + this.phone + ", accountID: " + this.accountID;
	}

}