package com.electronicstore.dao.implementations;

import com.electronicstore.dao.interfaces.ProductSpecDAO;
import com.electronicstore.model.ProductSpecification;
import com.electronicstore.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductSpecDAOImpl implements ProductSpecDAO {

    @Override
    public List<ProductSpecification> getSpecsByProductId(int productId) {
        List<ProductSpecification> specs = new ArrayList<>();
        String sql = "SELECT * FROM Product_Specifications WHERE product_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, productId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    ProductSpecification spec = new ProductSpecification();
                    spec.setId(rs.getInt("id"));
                    spec.setProductId(rs.getInt("product_id"));
                    spec.setSpecName(rs.getString("spec_name"));
                    spec.setSpecValue(rs.getString("spec_value"));
                    specs.add(spec);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return specs;
    }
}