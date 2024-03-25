package CartPage;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Connect.DBConnectionManager;
import yourpackage.Product;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Product> cartProducts = getCartProducts(request);

        request.setAttribute("cartProducts", cartProducts);
        request.getRequestDispatcher("/cart.jsp").forward(request, response);
    }

    public List<Product> getCartProducts(HttpServletRequest request) {
        List<Product> cartProducts = new ArrayList<>();

        try (Connection connection = DBConnectionManager.getConnection()) {
            String query = "SELECT p.product_id, p.product_name, p.product_price, p.product_category, p.product_description, pi.image_url, c.quantity " +
                           "FROM products p " +
                           "INNER JOIN cart c ON p.product_id = c.product_id " +
                           "LEFT JOIN product_images pi ON p.product_id = pi.product_id " +
                           "WHERE c.user_id = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setInt(1, getUserIdFromSession(request));
                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    while (resultSet.next()) {
                        int productId = resultSet.getInt("product_id");
                        String productName = resultSet.getString("product_name");
                        String productPrice = resultSet.getString("product_price");
                        String productCategory = resultSet.getString("product_category");
                        String productDescription = resultSet.getString("product_description");
                        String productImageUrl = resultSet.getString("image_url");
                        int quantity = resultSet.getInt("quantity");

                        Product product = new Product(productId, productName, productPrice, productCategory, productDescription, productImageUrl,quantity);
                        cartProducts.add(product);
               }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle exception
        }

        return cartProducts;
    }
    // Dummy method, replace with actual logic to get user id from session
    private int getUserIdFromSession(HttpServletRequest request) {
    	 HttpSession session = request.getSession();
    	    String userEmail = (String) session.getAttribute("email");

    	    int userId = 0; // Default value if user ID is not found or error occurs

    	    if (userEmail != null) {
    	        try (Connection connection = DBConnectionManager.getConnection()) {
    	            String sql = "SELECT user_id FROM users WHERE email = ?";
    	            PreparedStatement statement = connection.prepareStatement(sql);
    	            statement.setString(1, userEmail);
    	            ResultSet resultSet = statement.executeQuery();

    	            if (resultSet.next()) {
    	                userId = resultSet.getInt("user_id");
    	            }
    	        } catch (SQLException e) {
    	            e.printStackTrace();
    	            // Handle database connection or query errors
    	        }
    	    }

    	    return userId;
    }
    
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve the product ID from the request
        int productId = Integer.parseInt(request.getParameter("productId"));
        
        // Call a method to delete the product with the specified ID from the cart
        boolean deletionSuccessful = deleteProductFromCart(productId,request);
        
        // Set appropriate response status and message
        if (deletionSuccessful) {
            response.setStatus(HttpServletResponse.SC_OK); // 200 OK
        } else {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 500 Internal Server Error
        }
    }

    private boolean deleteProductFromCart(int productId, HttpServletRequest request) {
        try (Connection connection = DBConnectionManager.getConnection()) {
            String query = "DELETE FROM cart WHERE product_id = ? AND user_id = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setInt(1, productId);
                preparedStatement.setInt(2, getUserIdFromSession(request));
                preparedStatement.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle exception
        }
		return true;
    }
}
