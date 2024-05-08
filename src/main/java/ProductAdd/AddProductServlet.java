package ProductAdd;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Connect.DBConnectionManager;
//@WebServlet("/AddProductServlet")
public class AddProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        String productName = request.getParameter("product-name");
        String productCategory = request.getParameter("product-category");
        String productPrice = request.getParameter("product-price");
        String productQuantity = request.getParameter("product-quantity");
        String productDescription = request.getParameter("product-description");
        String[] productImages = request.getParameterValues("product-images");

        try (Connection connection = DBConnectionManager.getConnection()) {
            String insertQuery = "INSERT INTO products (product_name, product_category, product_price, product_quantity, product_description) VALUES (?, ?, ?, ?, ?)";

            try (PreparedStatement preparedStatement = connection.prepareStatement(insertQuery, PreparedStatement.RETURN_GENERATED_KEYS)) {
                preparedStatement.setString(1, productName);
                preparedStatement.setString(2, productCategory);
                preparedStatement.setString(3, productPrice);
                preparedStatement.setString(4, productQuantity);
                preparedStatement.setString(5, productDescription);

                int rowsAffected = preparedStatement.executeUpdate();

                if (rowsAffected > 0) {
                    // Retrieve the auto-generated keys (product_id)
                    try (ResultSet generatedKeys = preparedStatement.getGeneratedKeys()) {
                        if (generatedKeys.next()) {
                            int productId = generatedKeys.getInt(1);

                            // Now you have the product_id, you can use it for other operations
                            // For example, inserting product images
                            if (productImages != null) {
                                for (String image : productImages) {
                                    String insertImageQuery = "INSERT INTO product_images (product_id, image_url) VALUES (?, ?)";
                                    
                                    try (PreparedStatement imageStatement = connection.prepareStatement(insertImageQuery)) {
                                        imageStatement.setInt(1, productId);
                                        imageStatement.setString(2, image);
                                        imageStatement.executeUpdate();
                                    }
                                }
                            }
                        } else {
                            // Failed to retrieve the auto-generated key
                            // Handle this situation as needed
                            response.sendRedirect("error.jsp");
                            return; // Exit the method to prevent redirection to success.jsp
                        }
                    }
                } else {
                    // No rows affected, indicating insertion failure
                    // Handle this situation as needed
                    response.sendRedirect("error.jsp");
                    return; // Exit the method to prevent redirection to success.jsp
                }
            }

            // Redirect to a success page or handle response as needed
            response.sendRedirect("success.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions and redirect to an error page if necessary
            response.sendRedirect("error.jsp");
        }
    }
}
