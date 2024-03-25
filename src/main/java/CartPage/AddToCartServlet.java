package CartPage;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import Connect.DBConnectionManager;

//@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("email") != null) {
            String email = (String) session.getAttribute("email");
            
            // Retrieve user_id from the Users table using the email
            int userId = getUserIdByEmail(email);
            

            if(userId != -1) { // Ensure the user_id is valid
                int productId = Integer.parseInt(request.getParameter("product_id"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));

             // Check if the product is already in the cart for this user
                if (isProductInCart(userId, productId)) {
                    // If the product is already in the cart, update the quantity
                    updateQuantityInCart(userId, productId, quantity);
                } else {
                    // If the product is not in the cart, insert it
                    insertProductIntoCart(userId, productId, quantity,response);
                }

             } else {
                // Handle the case where user_id is not found for the given email
                response.sendRedirect("error.jsp");
            }
        } else {
            // Redirect to login page or show an error message
            response.sendRedirect("login.jsp");
        }
    }
    // Method to retrieve user_id from Users table using email
    private int getUserIdByEmail(String email) {
        int userId = -1;
       
         try (Connection connection = DBConnectionManager.getConnection()) {
            String query = "SELECT user_id FROM users WHERE email = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setString(1, email);
                 try (ResultSet resultSet = preparedStatement.executeQuery()) {
                     if (resultSet.next()) {
                         userId = resultSet.getInt("user_id");
                     }
                 }
             }
        } catch (SQLException e) {
             e.printStackTrace();
         }
        return userId;
    }
    
    
 // Method to check if a product is already in the cart for a given user
    private boolean isProductInCart(int userId, int productId) {
        try (Connection connection = DBConnectionManager.getConnection()) {
            String query = "SELECT * FROM Cart WHERE user_id = ? AND product_id = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setInt(1, userId);
                preparedStatement.setInt(2, productId);
                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    return resultSet.next(); // Return true if the product is found in the cart
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; // Return false if there was an error or if the product is not found in the cart
    }

    // Method to update the quantity of a product in the cart for a given user
    private void updateQuantityInCart(int userId, int productId, int quantity) {
        try (Connection connection = DBConnectionManager.getConnection()) {
            String updateQuery = "UPDATE Cart SET quantity = quantity + ? WHERE user_id = ? AND product_id = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(updateQuery)) {
                preparedStatement.setInt(1, quantity);
                preparedStatement.setInt(2, userId);
                preparedStatement.setInt(3, productId);
                preparedStatement.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

 // Method to insert a new product into the cart for a given user
    private void insertProductIntoCart(int userId, int productId, int quantity, HttpServletResponse response) throws IOException {
        try (Connection connection = DBConnectionManager.getConnection()) {
            if (isQuantityAvailable(productId, quantity)) {
                // Insert product into cart
                String insertQuery = "INSERT INTO Cart (user_id, product_id, quantity) VALUES (?, ?, ?)";
                try (PreparedStatement preparedStatement = connection.prepareStatement(insertQuery)) {
                    preparedStatement.setInt(1, userId);
                    preparedStatement.setInt(2, productId);
                    preparedStatement.setInt(3, quantity);
                    preparedStatement.executeUpdate();
                    // Send success response
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write("{\"success\": true, \"message\": \"Product added to cart successfully!\"}");
                }
            } else {
                // Product is out of stock, send error response
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"success\": false, \"message\": \"Product is out of stock.\"}");
            }
        } catch (SQLException | IOException e) {
            e.printStackTrace();
            // Send error response if an exception occurs
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"success\": false, \"message\": \"An error occurred while adding the product to cart.\"}");
        }
    }


    // Method to check if the requested quantity of a product is available in the products table
    private boolean isQuantityAvailable(int productId, int requestedQuantity) {
        try (Connection connection = DBConnectionManager.getConnection()) {
            String query = "SELECT product_quantity FROM products WHERE product_id = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setInt(1, productId);
                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    if (resultSet.next()) {
                        int availableQuantity = resultSet.getInt("product_quantity");
                        System.out.println("Hello");
                        return availableQuantity >= requestedQuantity; // Return true if quantity is available
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; // Return false if there was an error or if the product is not found
    }

}
