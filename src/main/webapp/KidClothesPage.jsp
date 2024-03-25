<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, ProductList.ProductListServlet, yourpackage.Product" %>

<jsp:include page="View/Header.jsp" />
<!-- ***** Products Area Starts ***** -->
<section class="section" id="products">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="section-heading">
                    <h2>Our Latest Products</h2>
                    <span>Check out all of our products.</span>
                </div>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="row">
    <%
        ProductListServlet productListServlet = new ProductListServlet();
        List<Product> products = productListServlet.getProducts();
        if (!products.isEmpty()) {
            for (Product product : products) {
                if ("kids".equals(product.getProductCategory())) { // Check if the product category is "women"
    %>
    <div class="col-lg-4">
        <div class="item">
            <div class="thumb">
                <div class="hover-content">
                    <ul>
                        <li><a href="single-product.jsp?productId=<%= product.getProductId() %>"><i class="fa fa-eye"></i></a></li>
                        <!-- Add other links as needed -->
                    </ul>
                </div>
                <img src="<%= product.getProductImageUrl() %>" alt="<%= product.getProductName() %>">
            </div>
            <div class="down-content">
                <h4><%= product.getProductName() %></h4>
                <span>INR <%= product.getProductPrice() %></span>
                <!-- Add other product details as needed -->
            </div>
        </div>
    </div>
    <%
                }
            }
        } else {
    %>
    <p>No products available</p>
    <%
        }
    %>
</div>

    </div>
</section>
