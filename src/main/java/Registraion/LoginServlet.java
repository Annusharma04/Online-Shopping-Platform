package Registraion;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Connect.DBConnectionManager;

//@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("signin-email");
        String password = request.getParameter("signin-password");
        String role = request.getParameter("signin-role");
        // Check user credentials
        if (authenticateUser(email, password, role)) {
            // Redirect to the appropriate page based on the user's role
            if ("customer".equals(role)) {
                HttpSession session = request.getSession();

            	session.setAttribute("email",email);
                response.sendRedirect("AfterLogin.jsp");                
            } else if ("admin".equals(role)) {
                response.sendRedirect("Main.jsp");
            } else {
                // Invalid role, handle appropriately (e.g., show an error message)
                response.sendRedirect("error.jsp");
            }
        } else {
            // If login fails, show a popup message
            response.setContentType("text/html");
            response.getWriter().println("<script>alert('Your username and password are wrong');</script>");
            response.sendRedirect("login.html"); // Redirect back to the login page
        }
    }

    private boolean authenticateUser(String email, String password, String role) {
    	try {
    		 Connection connection = null;
    	     PreparedStatement preparedStatement = null;
    	     ResultSet resultSet=null;
            connection = DBConnectionManager.getConnection();
            String query = "SELECT * FROM users WHERE email = ? AND password = ? AND role = ?";
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, email);
            preparedStatement.setString(2, password);
            preparedStatement.setString(3, role);
            resultSet = preparedStatement.executeQuery();
            return resultSet.next(); // Returns true if a matching user is found, false otherwise
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle SQL exception (e.g., log error, return false)
            return false;
        } 
    }
}
