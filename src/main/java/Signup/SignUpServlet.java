package Signup;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Connect.DBConnectionManager;

//@WebServlet("/SignUpServlet")
public class SignUpServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

 // ... (previous code)

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String name = request.getParameter("signup-name");
        String email = request.getParameter("signup-email");
        String password = request.getParameter("signup-password");
        String role = request.getParameter("signup-role");

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = DBConnectionManager.getConnection();

            String insertQuery = "INSERT INTO users (name, email, password, role) VALUES (?, ?, ?, ?)";
            preparedStatement = connection.prepareStatement(insertQuery);
            preparedStatement.setString(1, name);
            preparedStatement.setString(2, email);
            preparedStatement.setString(3, password);
            preparedStatement.setString(4, role);
            int rowsAffected = preparedStatement.executeUpdate();

            if (rowsAffected > 0) {
                // Registration successful
                String redirectPage;
                if ("admin".equals(role)) {
                    redirectPage = "index.html"; // Change to the actual admin page
                } else {
                    redirectPage = "customerpage.jsp"; // Change to the actual customer page
                }

                // Redirect with a success message
                response.sendRedirect(redirectPage + "?signupSuccess=true");

            } else {
                // Registration failed
                out.println("<script>alert('Signup failed. Please try again.');</script>");
                RequestDispatcher rd = request.getRequestDispatcher("signup.html"); // Change to your signup page
                rd.include(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}

