/**
 * 
 */
package com.banthatlung.Dao.model;

/**
 * 
 */
public class Inventory {
	private int productID;
    private int initialQuantity;
    private int currentQuantity;
    private double consumptionPercent;
    private String reorderStatus; // "Cần nhập kho", "Nên nhập kho", "Không cần nhập kho"

    public Inventory() {}
    
	public Inventory(int productId, int initialQuantity, int currentQuantity) {
		this.productID = productId;
		this.initialQuantity = initialQuantity;
		this.currentQuantity = currentQuantity;
	}
	
	public int getProductID() {
		return productID;
	}

	public void setProductID(int productID) {
		this.productID = productID;
	}

	public int getInitialQuantity() {
		return initialQuantity;
	}

	public void setInitialQuantity(int initialQuantity) {
		this.initialQuantity = initialQuantity;
	}

	public int getCurrentQuantity() {
		return currentQuantity;
	}

	public void setCurrentQuantity(int currentQuantity) {
		this.currentQuantity = currentQuantity;
	}

	public double getConsumptionPercent() {
		return consumptionPercent;
	}

	public void setConsumptionPercent(double consumptionPercent) {
		this.consumptionPercent = consumptionPercent;
	}

	public String getReorderStatus() {
		return reorderStatus;
	}

	public void setReorderStatus(String reorderStatus) {
		this.reorderStatus = reorderStatus;
	}

	@Override
	public String toString() {
		return "Product ID: " + this.productID + "\n" +
				"Initial quantity: " + this.initialQuantity + ", current quantity: " + this.currentQuantity + "\n" +
				"Status: " + this.reorderStatus;
	}

}
