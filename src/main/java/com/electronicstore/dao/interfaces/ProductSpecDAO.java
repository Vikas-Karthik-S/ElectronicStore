package com.electronicstore.dao.interfaces;

import com.electronicstore.model.ProductSpecification;
import java.util.List;

public interface ProductSpecDAO {
    List<ProductSpecification> getSpecsByProductId(int productId);
}