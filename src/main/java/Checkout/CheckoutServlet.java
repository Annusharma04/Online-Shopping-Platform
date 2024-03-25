package Checkout;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Connect.DBConnectionManager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.UUID;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("email") != null) {
            String sessionemail = (String) session.getAttribute("email");

            // Retrieve user_id from the Users table using the email
            int userId = getUserIdByEmail(sessionemail);

            // Extract form data
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String companyName = request.getParameter("companyName");
            String address = request.getParameter("address");
            String townCity = request.getParameter("townCity");
            String country = request.getParameter("country");
            String postcode = request.getParameter("postcode");
            String mobile = request.getParameter("mobile");
            String email = request.getParameter("email");
            String notes = request.getParameter("notes");

            // Insert billing details into the database and get the generated billing
            // details ID
            int billingDetailsId = insertBillingDetails(userId, firstName, lastName, companyName, address, townCity,
                    country, postcode, mobile, email, notes);

            if (billingDetailsId != -1) {
                // Billing details inserted successfully

                // Check payment method
                String paymentMethod = request.getParameter("paymentMethod");
                if (paymentMethod.equals("cash_on_delivery")) {
                    // Fetch cart items for this user and insert into orders and orderdetails
                    // tables
                    insertOrder(userId, billingDetailsId);
                }

                // Redirect to a confirmation page
                response.sendRedirect("OrderedPlaced.jsp");
            } else {
                // Error handling
                response.sendRedirect("error.jsp");
            }
        }
    }

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

    private int insertBillingDetails(int userId, String firstName, String lastName, String companyName, String address,
            String townCity, String country, String postcode, String mobile, String email, String notes) {
        String sql = "INSERT INTO billing_details (user_id, first_name, last_name, company_name, address, "
                + "town_city, country, postcode, mobile, email, notes) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection connection = DBConnectionManager.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            // Set parameters
            statement.setInt(1, userId);
            statement.setString(2, firstName);
            statement.setString(3, lastName);
            if (companyName.isEmpty()) {
                statement.setNull(4, Types.VARCHAR);
            } else {
                statement.setString(4, companyName);
            }
            statement.setString(5, address);
            statement.setString(6, townCity);
            statement.setString(7, country);
            statement.setString(8, postcode);
            statement.setString(9, mobile);
            statement.setString(10, email);
            if (notes.isEmpty()) {
                statement.setNull(11, Types.VARCHAR);
            } else {
                statement.setString(11, notes);
            }
            // Execute the insert statement
            int rowsInserted = statement.executeUpdate();
            if (rowsInserted > 0) {
                // Retrieve the auto-generated ID
                try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        return generatedKeys.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        // Return -1 if insertion fails
        return -1;
    }

    private void insertOrder(int userId, int billingDetailsId) {
        String trackingNumber = generateUniqueTrackingNumber();

        // Fetch cart items for this user from the cart table
        String cartQuery = "SELECT product_id, quantity FROM cart WHERE user_id = ?";
        String orderQuery = "INSERT INTO orders (user_id, total_amount, status, payment_method, shipping_address,tracking_number) "
                + "VALUES (?, ?, ?, ?, ?,?)";
        String orderDetailsQuery = "INSERT INTO orderdetails (order_id, product_id, quantity, unit_price) "
                + "VALUES (?, ?, ?, ?)";
        String productUpdateQuery = "UPDATE products SET product_quantity = product_quantity - ? WHERE product_id = ?";

        try (Connection connection = DBConnectionManager.getConnection();
                PreparedStatement cartStatement = connection.prepareStatement(cartQuery);
                PreparedStatement orderStatement = connection.prepareStatement(orderQuery,
                        PreparedStatement.RETURN_GENERATED_KEYS);
                PreparedStatement orderDetailsStatement = connection.prepareStatement(orderDetailsQuery);
                PreparedStatement productUpdateStatement = connection.prepareStatement(productUpdateQuery)) {
            // Set parameters for cart query
            cartStatement.setInt(1, userId);
            try (ResultSet resultSet = cartStatement.executeQuery()) {
                double totalAmount = 0;
                // Set parameters for order statement
                orderStatement.setInt(1, userId);
                orderStatement.setDouble(2, totalAmount); // Placeholder, update after calculating
                orderStatement.setString(3, "pending");
                orderStatement.setString(4, "cash_on_delivery");
                orderStatement.setString(5, "India"); // Placeholder, update with actual address
                orderStatement.setString(6, trackingNumber);

                // Execute order statement
                int rowsInserted = orderStatement.executeUpdate();
                if (rowsInserted > 0) {
                    // Get the auto-generated order ID
                    try (ResultSet generatedKeys = orderStatement.getGeneratedKeys()) {
                        if (generatedKeys.next()) {
                            int orderId = generatedKeys.getInt(1);
                            // Execute order details statement for each cart item
                            while (resultSet.next()) {
                                int productId = resultSet.getInt("product_id");
                                int quantity = resultSet.getInt("quantity");
                                double unitPrice = getProductPrice(productId); // Fetch price from products table
                                totalAmount += unitPrice * quantity;
                                orderDetailsStatement.setInt(1, orderId);
                                orderDetailsStatement.setInt(2, productId);
                                orderDetailsStatement.setInt(3, quantity);
                                orderDetailsStatement.setDouble(4, unitPrice);
                                orderDetailsStatement.executeUpdate();

                                // Update product quantity
                                productUpdateStatement.setInt(1, quantity);
                                productUpdateStatement.setInt(2, productId);
                                productUpdateStatement.executeUpdate();
                            }
                            // Update total amount in the orders table
                            updateTotalAmount(orderId, totalAmount);
                            // Update billing details with the order ID
                            updateBillingDetailsWithOrderId(billingDetailsId, orderId);
                            // Delete cart items
                            deleteCartItems(userId);
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private double getProductPrice(int productId) {
        double price = 0;

        String query = "SELECT product_price FROM products WHERE product_id = ?";
        try (Connection connection = DBConnectionManager.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, productId);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    price = resultSet.getDouble("product_price");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return price;
    }

    private void deleteCartItems(int userId) {
        String deleteQuery = "DELETE FROM cart WHERE user_id = ?";
        try (Connection connection = DBConnectionManager.getConnection();
             PreparedStatement statement = connection.prepareStatement(deleteQuery)) {
            statement.setInt(1, userId);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void updateTotalAmount(int orderId, double totalAmount) {
        String updateQuery = "UPDATE orders SET total_amount = ? WHERE order_id = ?";
        try (Connection connection = DBConnectionManager.getConnection();
             PreparedStatement statement = connection.prepareStatement(updateQuery)) {
            statement.setDouble(1, totalAmount);
            statement.setInt(2, orderId);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    private String generateUniqueTrackingNumber() {
        // Generate a UUID (Universally Unique Identifier)
        UUID uuid = UUID.randomUUID();
        // Convert UUID to String and remove hyphens
        return uuid.toString().replaceAll("-", "");
    }
    
    private void updateBillingDetailsWithOrderId(int billingDetailsId, int orderId) {
        String updateQuery = "UPDATE billing_details SET order_id = ? WHERE id = ?";
        try (Connection connection = DBConnectionManager.getConnection();
             PreparedStatement statement = connection.prepareStatement(updateQuery)) {
            statement.setInt(1, orderId);
            statement.setInt(2, billingDetailsId);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
