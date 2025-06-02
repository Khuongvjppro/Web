/**
 *
 */
package com.banthatlung.Dao.model;

import java.io.Serializable;

/**
 *
 */
public class Log implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private String accountID;
	private int event_type; //1:them du lieu; 2: doc du lieu; 3:sua du lieu; 4:xoa du lieu
	private String timeStamp;
	private String description;

	public Log(int id, String accountID, int event_type, String timeStamp, String description) {
		super();
		this.id = id;
		this.accountID = accountID;
		this.event_type = event_type;
		this.timeStamp = timeStamp;
		this.description = description;
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

	public int getEvent_type() {
		return event_type;
	}

	public void setEvent_type(int event_type) {
		this.event_type = event_type;
	}

	public String getTimeStamp() {
		return timeStamp;
	}

	public void setTimeStamp(String timeStamp) {
		this.timeStamp = timeStamp;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@Override
	public String toString() {
		return "ID: " + this.id + ", time: " + this.timeStamp + "\n" +
				"User " + this.accountID + " " + this.description;
	}

}
