package com.banthatlung.services;

import java.util.List;
import java.util.Map;

public class ShippingService {
    private VietnamLocationService locationService = new VietnamLocationService();

    // Tính phí ship theo tỉnh
    public int calculateShippingFee(String province) {
        return locationService.getShippingFee(province);
    }

    // Tính tổng tiền (gồm giá trị đơn + phí ship)
    public int calculateTotalAmount(List<Map<String, Object>> cartItems, String province) {
        int totalPrice = 0;
        for (Map<String, Object> item : cartItems) {
            int price = (int) item.get("price");
            int quantity = (int) item.get("quantity");
            totalPrice += price * quantity;
        }
        int shippingFee = calculateShippingFee(province);
        return totalPrice + shippingFee;
    }
}
