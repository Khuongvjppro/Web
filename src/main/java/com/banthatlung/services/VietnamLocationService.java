package com.banthatlung.services;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.core.type.TypeReference;
import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class VietnamLocationService {
    private static final String FILE_PATH = "src/main/webapp/data/vietnam_location.json";
    private Map<String, Integer> shippingFees = new HashMap<>();

    public VietnamLocationService() {
        // Định nghĩa bảng phí ship theo tỉnh thành
        shippingFees.put("Hà Nội", 20000);
        shippingFees.put("Hồ Chí Minh", 25000);
        // Thêm các tỉnh khác nếu cần
    }

    // Đọc danh sách tỉnh thành từ JSON
    public List<Map<String, Object>> getLocations() throws Exception {
        ObjectMapper mapper = new ObjectMapper();
        return mapper.readValue(new File(FILE_PATH), new TypeReference<List<Map<String, Object>>>() {});
    }

    // Lấy phí ship theo tỉnh
    public int getShippingFee(String province) {
        return shippingFees.getOrDefault(province, 30000); // Tỉnh khác: 30k
    }
}
