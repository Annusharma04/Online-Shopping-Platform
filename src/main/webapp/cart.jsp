<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="Connect.DBConnectionManager,yourpackage.Product,CartPage.CartServlet" %>
<%@ page import="java.util.*" %>
<jsp:include page="View/Header.jsp" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cart</title>
    <style>
        /*** Single Page Start ***/
        .pagination {
            display: inline-block;
        }

        .pagination a {
            color: var(--bs-dark);
            padding: 10px 16px;
            text-decoration: none;
            transition: 0.5s;
            border: 1px solid var(--bs-secondary);
            margin: 0 4px;
        }

        .pagination a.active {
            background-color: var(--bs-primary);
            color: var(--bs-light);
            border: 1px solid var(--bs-secondary);
        }

        .pagination a:hover:not(.active) {
            background-color: var(--bs-primary)
        }

        .nav.nav-tabs .nav-link.active {
            border-bottom: 2px solid var(--bs-secondary) !important;
        }

        /*** Single Page End ***/
    </style>
    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet">

    <!-- Icon Font Stylesheet -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="assets/css/lightbox.min.css" rel="stylesheet">
    <link href="assets/css/owl.carousel.min.css" rel="stylesheet">

    <!-- Customized Bootstrap Stylesheet -->
    <link href="assets/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <!-- Single Page Header start -->
    <div class="container-fluid page-header py-5">
        <h1 class="text-center text-white display-6">Cart</h1>
        <ol class="breadcrumb justify-content-center mb-0">
            <li class="breadcrumb-item"><a href="#">Home</a></li>
            <li class="breadcrumb-item"><a href="#">Pages</a></li>
            <li class="breadcrumb-item active text-white">Cart</li>
        </ol>
    </div>
    <!-- Single Page Header End -->

    <!-- Cart Page Start -->
    <div class="container-fluid py-5">
        <div class="container py-5">
            <div class="table-responsive">
                <table class="table">
                    <thead>
                      <tr>
                        <th scope="col">Products</th>
                        <th scope="col">Name</th>
                        <th scope="col">Price</th>
                        <th scope="col">Quantity</th>
                        <th scope="col">Total</th>
                        <th scope="col">Handle</th>
                      </tr>
                    </thead>
                    <tbody>
                        <% 
                        CartServlet cartServlet = new CartServlet();
                        List<Product> products = cartServlet.getCartProducts(request);
                        double subtotal = 0.0;

                        if (!products.isEmpty()) {
                            for (Product product : products) {
                                double productPrice = Double.parseDouble(product.getProductPrice());
                                int quantity = 1; // Default quantity for now, you should get the actual quantity from the cart
                                double total = productPrice * quantity;
                                subtotal += total; // Add to subtotal
                            %>
                             <tr>
                                <th scope="row">
                                    <div class="d-flex align-items-center">
                                        <img src="assets/images/<%= product.getProductImageUrl() %>" class="img-fluid me-5 rounded-circle" style="width: 80px; height: 80px;" alt="">
                                    </div>
                                </th>
                                <td>
                                    <p class="mb-0 mt-4"><%= product.getProductName() %></p>
                                </td>
                                <td>
                                    <p class="mb-0 mt-4" id="productPrice_<%= product.getProductId() %>"><%= product.getProductPrice() %> INR</p>
                               </td>

                                <td>
                                     <div class="input-group quantity mt-4" style="width: 100px;">
                                      <div class="input-group-btn">
                                            <button class="btn btn-sm btn-minus rounded-circle bg-light border" onclick="decrementQuantity(<%= product.getProductId() %>)">
                                                <i class="fa fa-minus"></i>
                                            </button>
                                        </div>
                                        <input id="quantityInput_<%= product.getProductId() %>" type="text" class="form-control form-control-sm text-center border-0" name="quantity" value="<%= product.getQuantity() %>">
                                         <div class="input-group-btn">
                                            <button class="btn btn-sm btn-plus rounded-circle bg-light border" onclick="incrementQuantity(<%= product.getProductId() %>)">
                                                <i class="fa fa-plus"></i>
                                            </button>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                     <p class="mb-0 mt-4" id="totalAmount_<%= product.getProductId() %>"><%= product.getProductPrice() %> INR</p>                       
                                </td>
                                <td>
                                    <button class="btn btn-md rounded-circle bg-light border mt-4" onclick="deleteProduct(<%= product.getProductId() %>)">
                                        <i class="fa fa-times text-danger"></i>
                                    </button>
                                </td>
                            </tr>
                        <% 
                            } // End of for loop
                        } else { // Display message if cart is empty
                        %>
                        <tr>
                            <td colspan="6" class="text-center">No products available in cart.</td>
                        </tr>
                        <% 
                        } // End of if-else block
                        %>
                    </tbody>
                </table>
            </div>
            
            <%if (!products.isEmpty()){%>
                <div class="mt-5">
                    <input type="text" class="border-0 border-bottom rounded me-5 py-3 mb-4" placeholder="Coupon Code">
                    <button class="btn border-secondary rounded-pill px-4 py-3 text-primary" type="button">Apply Coupon</button>
                </div>
                <div class="row g-4 justify-content-end">
                    <div class="col-sm-9 col-md-7 col-lg-6 col-xl-4">
                        <div class="bg-light rounded">
                            <div class="p-4">
                                <h1 class="display-6 mb-4">Cart <span class="fw-normal">Total</span></h1>
                                <div class="d-flex justify-content-between mb-4">
                                    <h5 class="mb-0 me-4">Subtotal:</h5>
                                   <p class="cartTotalAmount mb-0">INR 0.00</p> <!-- Display subtotal here -->
                                </div>
                                <div class="d-flex justify-content-between">
                                    <h5 class="mb-0 me-4">Shipping</h5>
                                    <div class="">
                                        <p class="mb-0">Free Shipping</p>
                                    </div>
                                </div>
                            </div>
                            <div class="py-4 mb-4 border-top border-bottom d-flex justify-content-between">
                                <h5 class="mb-0 me-4">Total</h5>
                                <p class="cartTotalAmount mb-0">INR 0.00</p> <!-- Add shipping to subtotal for total -->
                            </div>
                            <button class="btn border-secondary rounded-pill px-4 py-3 text-primary text-uppercase mb-4 ms-4" type="button" onclick="redirectToCheckout()">Proceed Checkout</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%} %>
    <!-- Cart Page End --> 

    <script>
    
    document.addEventListener("DOMContentLoaded", function() {
        // Call the updateCartTotal function when the page finishes loading
        updateCartTotal();
        <% for (Product product : products) { %>
            calculateTotal(<%= product.getProductId() %>);
        <% } %>
    });
    
    
    function calculateOverallTotal() {
        var overallTotal = 0;
        <% for (Product product : products) { %>
            var productId = <%= product.getProductId() %>;
            var quantityInput = document.getElementById("quantityInput_" + productId);
            var quantity = parseInt(quantityInput.value);
            var productPrice = parseFloat(document.getElementById("productPrice_" + productId).innerText.split(" ")[0]);
            var totalAmount = quantity * productPrice;
            overallTotal += totalAmount;
        <% } %>
        return overallTotal.toFixed(2); // Round to 2 decimal places
    }

    function updateCartTotal() {
        var cartTotalAmount = calculateOverallTotal();
        var elements = document.getElementsByClassName("cartTotalAmount");
        for (var i = 0; i < elements.length; i++) {
            elements[i].innerText = "INR " + cartTotalAmount;
        }
    }
    
    
    function redirectToCheckout() {
        // Redirect the user to the checkout.jsp page
        window.location.href = "CheckOut.jsp";
    }

    function deleteProduct(productId) {
        if (confirm("Are you sure you want to delete this product?")) {
            fetch('CartServlet?productId=' + productId, {
                method: 'DELETE'
            }).then(response => {
                if (response.ok) {
                    // Refresh the page or update the cart content as needed
                    window.location.reload();
                } else {
                    alert('Failed to delete the product.');
                }
            }).catch(error => {
                console.error('Error deleting product:', error);
            });
        }
    }

    function incrementQuantity(productId) {
        var quantityInput = document.getElementById("quantityInput_" + productId);
        var currentQuantity = parseInt(quantityInput.value);
        quantityInput.value = currentQuantity + 1;
        calculateTotal(productId);
    }

    function decrementQuantity(productId) {
        var quantityInput = document.getElementById("quantityInput_" + productId);
        var currentQuantity = parseInt(quantityInput.value);
        if (currentQuantity > 1) {
            quantityInput.value = currentQuantity - 1;
            calculateTotal(productId);
        }
    }
    
    function calculateTotal(productId) {
        var quantityInput = document.getElementById("quantityInput_" + productId);
        var quantity = parseInt(quantityInput.value);
        var productPrice = parseFloat(document.getElementById("productPrice_" + productId).innerText);
        var totalAmount = quantity * productPrice;
        document.getElementById("totalAmount_" + productId).innerText = totalAmount + " INR";
        updateCartTotal();
    }

    </script>
</body>
</html>
