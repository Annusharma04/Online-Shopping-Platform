package Checkout;

import Connect.DBConnectionManager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class MyOrders {

    public static ArrayList<OrderDetails> fetchOrderDetails(String userEmail) {
        ArrayList<OrderDetails> orderDetails = new ArrayList<>();

        // Establish database connection
        try (Connection connection = DBConnectionManager.getConnection()) {
            // Prepare SQL statement to fetch order details
            String query = "SELECT od.order_id, od.product_id, od.unit_price, od.quantity, " +
                    "o.order_date, o.total_amount, o.status, o.payment_method, o.shipping_address, " +
                    "o.tracking_number, o.created_at, o.updated_at, p.product_name, pi.image_url " +
                    "FROM orderdetails od " +
                    "JOIN orders o ON od.order_id = o.order_id " +
                    "JOIN products p ON od.product_id = p.product_id " +
                    "JOIN product_images pi ON od.product_id = pi.product_id " +
                    "WHERE o.user_id = (SELECT user_id FROM users WHERE email = ?)";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setString(1, userEmail);
                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    // Iterate through the result set and create OrderDetail objects
                    while (resultSet.next()) {
                        int orderId = resultSet.getInt("order_id");
                        // Fetch billing details for the current order
                        ArrayList<OrderBillingDetails> billingDetails = fetchBillingDetailsForOrder(orderId);
                        // Create an OrderDetail object and add it to the list
                        OrderDetails orderDetail = extractOrderDetailsFromResultSet(resultSet);
                        orderDetail.setBillingDetails(billingDetails);
                        orderDetails.add(orderDetail);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderDetails;
    }

    public static ArrayList<OrderBillingDetails> fetchBillingDetailsForOrder(int orderId) {
        ArrayList<OrderBillingDetails> billingDetails = new ArrayList<>();

        // Establish database connection
        try (Connection connection = DBConnectionManager.getConnection()) {
            // Prepare SQL statement to fetch billing details for the given order ID
            String query = "SELECT * FROM billing_details WHERE order_id = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setInt(1, orderId);
                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    // Iterate through the result set and create OrderBillingDetails objects
                    while (resultSet.next()) {
                        // Extract billing details from the result set
                        OrderBillingDetails billingDetail = extractBillingDetailsFromResultSet(resultSet);
                        billingDetails.add(billingDetail);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return billingDetails;
    }

    private static OrderDetails extractOrderDetailsFromResultSet(ResultSet resultSet) throws SQLException {
        int orderId = resultSet.getInt("order_id");
        int productId = resultSet.getInt("product_id");
        double unitPrice = resultSet.getDouble("unit_price");
        int quantity = resultSet.getInt("quantity");
        double totalAmount = resultSet.getDouble("total_amount");
        String orderDate = resultSet.getString("order_date");
        String status = resultSet.getString("status");
        String paymentMethod = resultSet.getString("payment_method");
        String shippingAddress = resultSet.getString("shipping_address");
        String trackingNumber = resultSet.getString("tracking_number");
        String createdAt = resultSet.getString("created_at");
        String updatedAt = resultSet.getString("updated_at");
        String productName = resultSet.getString("product_name");
        String imageUrl = resultSet.getString("image_url");

        return new OrderDetails(orderId, productId, unitPrice, quantity, totalAmount,
                orderDate, status, paymentMethod, shippingAddress,
                trackingNumber, createdAt, updatedAt,
                productName, imageUrl);
    }

    private static OrderBillingDetails extractBillingDetailsFromResultSet(ResultSet resultSet) throws SQLException {
        int id = resultSet.getInt("id");
        int userId = resultSet.getInt("user_id");
        String firstName = resultSet.getString("first_name");
        String lastName = resultSet.getString("last_name");
        String companyName = resultSet.getString("company_name");
        String address = resultSet.getString("address");
        String townCity = resultSet.getString("town_city");
        String country = resultSet.getString("country");
        String postcode = resultSet.getString("postcode");
        String mobile = resultSet.getString("mobile");
        String email = resultSet.getString("email");
        String notes = resultSet.getString("notes");
        int orderId = resultSet.getInt("order_id");

        return new OrderBillingDetails(id, userId, firstName, lastName, companyName, address,
                townCity, country, postcode, mobile, email, notes, orderId);
    }
}
