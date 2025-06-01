/**
 * 
 */
package com.banthatlung.Dao.model;

/**
 * 
 */
public class QuarterlyReport {
	private int quarter;
    private int productID;
    private String productName;
    private int totalQuantity;
    private double totalRevenue;

    public QuarterlyReport() {
    	
    }

	public QuarterlyReport(int quarter, int productID, String productName, int totalQuantity, double totalRevenue) {
		super();
		this.quarter = quarter;
		this.productID = productID;
		this.productName = productName;
		this.totalQuantity = totalQuantity;
		this.totalRevenue = totalRevenue;
	}

	public int getQuarter() {
		return quarter;
	}

	public void setQuarter(int quarter) {
		this.quarter = quarter;
	}

	public int getProductID() {
		return productID;
	}

	public void setProductID(int productID) {
		this.productID = productID;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public int getTotalQuantity() {
		return totalQuantity;
	}

	public void setTotalQuantity(int totalQuantity) {
		this.totalQuantity = totalQuantity;
	}

	public double getTotalRevenue() {
		return totalRevenue;
	}

	public void setTotalRevenue(double totalRevenue) {
		this.totalRevenue = totalRevenue;
	}

	@Override
	public String toString() {
		return "Ten san pham: "+ this.productName + "tong so san pham ban:" + this.totalQuantity +
				" , Doanh thu: " + this.totalRevenue + "\n";
	}

}
