package UserProfle;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import Connect.DBConnectionManager;

public class Profile extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action != null) {
            switch (action) {
                case "updateUserDetails":
                    updateUserDetails(request, response);
                    break;
                case "changePassword":
                    changePassword(request, response);
                    break;
                default:
                    // Handle invalid action
                    break;
            }
        }
    }

    
    private void updateUserDetails(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve edited details from request parameters
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String mobile = request.getParameter("mobile");
        String townCity = request.getParameter("townCity");
        String country = request.getParameter("country");
        String postcode = request.getParameter("postcode");

        // Get the session email ID
        HttpSession session = request.getSession();
        String sessionEmail = (String) session.getAttribute("email");

        // Check if session email is not null
        if (sessionEmail != null) {
            try {
                // Connect to your database
                Connection connection = DBConnectionManager.getConnection();

                // Check if the user is changing the email
                if (!email.equals(sessionEmail)) {
                    // If email is being changed, update session email
                    session.setAttribute("email", email);
                }

                // Update users table
                PreparedStatement updateUserStmt = connection.prepareStatement("UPDATE users SET first_name = ?, email = ?,last_name = ?,town_city = ?,country = ?,postcode = ?,mobile = ? WHERE email = ?");
                updateUserStmt.setString(1, firstName);
                updateUserStmt.setString(2, email);
                updateUserStmt.setString(3, lastName);
                updateUserStmt.setString(4,townCity);
                updateUserStmt.setString(5, country);
                updateUserStmt.setString(6, postcode);
                updateUserStmt.setString(7, mobile);
                updateUserStmt.setString(8, sessionEmail);
                updateUserStmt.executeUpdate();

                // Close the connection
                connection.close();

                // Send success response back to client
                response.getWriter().write("User details updated successfully");
            } catch (SQLException e) {
                e.printStackTrace();
                // Handle database errors
                response.getWriter().write("Error occurred while updating user details");
            }
        } else {
            // Session email is null, handle accordingly
            response.getWriter().write("Session email is null");
        }
    }

    private void changePassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve old and new passwords from request parameters
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");

        // Check if old password matches the one stored in the database
        // Implement your password validation logic here

        // If old password matches, update the password in the database with the new one
        // Implement your password update logic here

        // Send success response back to client
        response.getWriter().write("Password changed successfully");
    }
    
    
    
    
    
    // Define method to fetch user and billing details and store in list
    public static List<UserBillingDetails> fetchUserBillingDetails(String userEmail) {
        List<UserBillingDetails> userDetailsList = new ArrayList<>();

        // SQL query to fetch user and billing details
        String query = "SELECT * FROM users WHERE email = ?";

        try (Connection connection = DBConnectionManager.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            // Set parameter for the email
            preparedStatement.setString(1, userEmail);
            // Execute the query
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                // Iterate through the result set and populate the list
                while (resultSet.next()) {
                	
                    String userRole = resultSet.getString("role");
                    int userId = resultSet.getInt("user_id");
                    String firstName = resultSet.getString("first_name");
                    String lastName = resultSet.getString("last_name");
                    String townCity = resultSet.getString("town_city");
                    String country = resultSet.getString("country");
                    String postcode = resultSet.getString("postcode");
                    String mobile = resultSet.getString("mobile");

                    // Create a new UserBillingDetails object and add it to the list
                    UserBillingDetails userDetails = new UserBillingDetails( userEmail, userRole, userId,
                            firstName, lastName, townCity, country, postcode, mobile);
                    userDetailsList.add(userDetails);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return userDetailsList;
    }

}
