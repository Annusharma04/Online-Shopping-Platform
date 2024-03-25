package ProductList;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Connect.DBConnectionManager;
import yourpackage.Product;

public class ProductListServlet {

    public List<Product> getProducts() {
        List<Product> products = new ArrayList<>();

        try (Connection connection = DBConnectionManager.getConnection()) {
            String query = "SELECT * FROM products";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    while (resultSet.next()) {
                        int productId = resultSet.getInt("product_id");
                        String productName = resultSet.getString("product_name");
                        String productPrice = resultSet.getString("product_price");
                        String productCategory = resultSet.getString("product_category");
                        String productDescription=resultSet.getString("product_description");

                        // Assuming you have a method to get the first image URL associated with the product
                        String productImageUrl = getProductImageUrl(productId);

                        Product product = new Product(productId, productName, productPrice,productCategory,productDescription, productImageUrl);
                        products.add(product);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return products;
    }

    // Method to retrieve the first image URL associated with the product
    private String getProductImageUrl(int productId) {
    	 String imageUrl = null;
    	    try (Connection connection = DBConnectionManager.getConnection()) {
    	        String query = "SELECT image_url FROM product_images WHERE product_id = ?";
    	        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
    	            preparedStatement.setInt(1, productId);
    	            try (ResultSet resultSet = preparedStatement.executeQuery()) {
    	                if (resultSet.next()) {
    	                	String image=resultSet.getString("image_url");
    	                    imageUrl ="assets/images/" + image;
    	                }
    	            }
    	        }
    	    } catch (SQLException e) {
    	        e.printStackTrace();
    	        // Handle exception
    	    }

    	    // If imageUrl is null, return the default image URL
    	    if (imageUrl == null) {
    	        imageUrl = "assets/images/women-02.jpg";
    	    }

    	    return imageUrl;
    }
}
