package OrderPage;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import Connect.DBConnectionManager;

public class CheckOrder  {

    public List<OrderDetails> getOrders() {

        List<OrderDetails> orderDetailsList = new ArrayList<>();
        try (Connection connection = DBConnectionManager.getConnection()) {
            String query = "SELECT o.order_id, p.product_name, u.first_name, o.order_date, o.status, o.total_amount " +
                           "FROM Orders o " +
                           "JOIN OrderDetails od ON o.order_id = od.order_id " +
                           "JOIN Products p ON od.product_id = p.product_id " +
                           "JOIN Users u ON o.user_id = u.user_id";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    while (resultSet.next()) {
                        int orderId = resultSet.getInt("order_id");
                        String productName = resultSet.getString("product_name");
                        String userName = resultSet.getString("first_name");
                        String orderDate = resultSet.getString("order_date");
                        String status = resultSet.getString("status");
                        double totalAmount = resultSet.getDouble("total_amount");

                        OrderDetails orderDetails = new OrderDetails(orderId, productName, userName, orderDate, status, totalAmount);
                        orderDetailsList.add(orderDetails);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return orderDetailsList;
    }
}
