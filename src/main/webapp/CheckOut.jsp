<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="Connect.DBConnectionManager,yourpackage.Product,CartPage.CartServlet" %>
<%@ page import="java.util.*" %>
    <jsp:include page="View/Header.jsp" />
    
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <title>Fruitables - Vegetable Website Template</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="" name="keywords">
        <meta content="" name="description">

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

        <!-- Template Stylesheet -->
        <link href="css/style.css" rel="stylesheet">
    </head>

    <body>

        

        


        


        <!-- Single Page Header start -->
        <div class="container-fluid page-header py-5">
            <h1 class="text-center text-white display-6">Checkout</h1>
            <ol class="breadcrumb justify-content-center mb-0">
                <li class="breadcrumb-item"><a href="#">Home</a></li>
                <li class="breadcrumb-item"><a href="#">Pages</a></li>
                <li class="breadcrumb-item active text-white">Checkout</li>
            </ol>
        </div>
        <!-- Single Page Header End -->


        <!-- Checkout Page Start -->
        <div class="container-fluid py-5">
            <div class="container py-5">
                <h1 class="mb-4">Billing details</h1>
                <form action="CheckoutServlet" method="post">
                    <div class="row g-5">
                        <div class="col-md-12 col-lg-6 col-xl-7">
                            <div class="row">
                                <div class="col-md-12 col-lg-6">
                                    <div class="form-item w-100">
                                        <label class="form-label my-3">First Name<sup>*</sup></label>
                                        <input type="text" id="firstName" class="form-control">
                                    </div>
                                </div>
                                <div class="col-md-12 col-lg-6">
                                    <div class="form-item w-100">
                                        <label class="form-label my-3">Last Name<sup>*</sup></label>
                                        <input type="text" id="lastName" class="form-control">
                                    </div>
                                </div>
                            </div>
                            <div class="form-item">
                                <label class="form-label my-3">Company Name</label>
                                <input type="text" id="companyName" class="form-control">
                            </div>
                            <div class="form-item">
                                <label class="form-label my-3">Address <sup>*</sup></label>
                                <input type="text" class="form-control" id="address" placeholder="House Number Street Name">
                            </div>
                            <div class="form-item">
                                <label class="form-label my-3">Town/City<sup>*</sup></label>
                                <input type="text" id="townCity" class="form-control">
                            </div>
                            <div class="form-item">
                                <label class="form-label my-3">Country<sup>*</sup></label>
                                <input type="text" id="country" class="form-control">
                            </div>
                            <div class="form-item">
                                <label class="form-label my-3">Postcode/Zip<sup>*</sup></label>
                                <input type="text" id="postcode" class="form-control">
                            </div>
                            <div class="form-item">
                                <label class="form-label my-3">Mobile<sup>*</sup></label>
                                <input type="tel" id="mobile" class="form-control">
                            </div>
                            <div class="form-item">
                                <label class="form-label my-3">Email Address<sup>*</sup></label>
                                <input type="email" id="email" class="form-control">
                            </div>
                            <hr>
                          <!--<div class="form-check my-3">
                                <input class="form-check-input" type="checkbox" id="Address-1" name="Address" value="Address">
                                <label class="form-check-label" for="Address-1">Ship to a different address?</label>
                            </div>-->
                            <div class="form-item">
                                <label class="form-label my-3">Order Notes</label>
                                <textarea name="text" class="form-control" spellcheck="false" cols="30" rows="11" id="notes" placeholder="Order Notes (Optional)"></textarea>
                            </div>
                        </div>
                        <div class="col-md-12 col-lg-6 col-xl-5">
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th scope="col">Products</th>
                                            <th scope="col">Name</th>
                                            <th scope="col">Price</th>
                                            <th scope="col">Quantity</th>
                                            <th scope="col">Total</th>
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
                                                <div class="d-flex align-items-center mt-2">
                                                    <img src="assets/images/<%= product.getProductImageUrl() %>" class="img-fluid rounded-circle" style="width: 90px; height: 90px;" alt="">
                                                </div>
                                            </th>
                                            <td class="py-5"><%= product.getProductName() %></td>
                                            <td class="py-5" id="productPrice_<%= product.getProductId() %>"><%= product.getProductPrice() %> INR</td>
                                            <td class="py-5" id="quantityInput_<%= product.getProductId() %>"><%= product.getQuantity() %></td>
                                            <td class="py-5" id="totalAmount_<%= product.getProductId() %>"><%= product.getProductPrice() %> INR</td>
                                        </tr>
                                       <%} } %> 
                                        <tr>
                                            <th scope="row">
                                            </th>
                                            <td class="py-5"></td>
                                            <td class="py-5"></td>
                                            <td class="py-5">
                                                <p class="mb-0 text-dark py-3">Subtotal</p>
                                            </td>
                                            <td class="py-5">
                                                <div class="py-3 border-bottom border-top">
                                                    <p class="cartTotalAmount mb-0 text-dark" >INR 0.00</p>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                         <!--   <th scope="row">
                                            </th>
                                            <td class="py-5">
                                                <p class="mb-0 text-dark py-4">Shipping</p>
                                            </td>
                                           <td colspan="3" class="py-5">
                                                <div class="form-check text-start">
                                                    <input type="checkbox" class="form-check-input bg-primary border-0" id="Shipping-1" name="Shipping-1" value="Shipping">
                                                    <label class="form-check-label" for="Shipping-1">Free Shipping</label>
                                                </div>
                                                <div class="form-check text-start">
                                                    <input type="checkbox" class="form-check-input bg-primary border-0" id="Shipping-2" name="Shipping-1" value="Shipping">
                                                    <label class="form-check-label" for="Shipping-2">Flat rate: $15.00</label>
                                                </div>
                                                <div class="form-check text-start">
                                                    <input type="checkbox" class="form-check-input bg-primary border-0" id="Shipping-3" name="Shipping-1" value="Shipping">
                                                    <label class="form-check-label" for="Shipping-3">Local Pickup: $8.00</label>
                                                </div>
                                            </td>
																		
                                        </tr>
                                        <tr>
                                            <th scope="row">
                                            </th>
                                            <td class="py-5">
                                                <p class="mb-0 text-dark text-uppercase py-3">TOTAL</p>
                                            </td>
                                            <td class="py-5"></td>
                                            <td class="py-5"></td>
                                            <td class="py-5">
                                                <div class="py-3 border-bottom border-top">
                                                    <p class="cartTotalAmount mb-0 text-dark">INR 0.00</p>
                                                </div>
                                            </td>
                                        </tr>
                                        
                                    -->    
                                    </tbody>
                                </table>
                            </div>
                          
                            <div class="row g-4 text-center align-items-center justify-content-center border-bottom py-3">
							    <div class="col-12">
							        <div class="form-check text-start my-3">
							            <input type="radio" class="form-check-input bg-primary border-0" id="CashOnDelivery" name="paymentMethod" value="cash_on_delivery">
							            <label class="form-check-label" for="CashOnDelivery">Cash On Delivery</label>
							        </div>
							    </div>
							</div>
							<div class="row g-4 text-center align-items-center justify-content-center border-bottom py-3">
							    <div class="col-12">
							        <div class="form-check text-start my-3">
							            <input type="radio" class="form-check-input bg-primary border-0" id="Paypal" name="paymentMethod" value="paypal">
							            <label class="form-check-label" for="Paypal">Paypal</label>
							        </div>
							    </div>
							</div>
                            <div class="row g-4 text-center align-items-center justify-content-center pt-4">
                                <button id="placeOrderButton" type="button" class="btn border-secondary py-3 px-4 text-uppercase w-100 text-primary">Place Order</button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <!-- Checkout Page End -->






        <!-- Back to Top -->
        <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i class="fa fa-arrow-up"></i></a>   

        
    <!-- JavaScript Libraries -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="lib/easing/easing.min.js"></script>
    <script src="lib/waypoints/waypoints.min.js"></script>
    <script src="lib/lightbox/js/lightbox.min.js"></script>
    <script src="lib/owlcarousel/owl.carousel.min.js"></script>

    <!-- Template Javascript -->
    <script src="js/main.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
document.addEventListener("DOMContentLoaded", function() {
    console.log("DOM Loaded");
    // Call the updateCartTotal function when the page finishes loading
    updateCartTotal();
    <% for (Product product : products) { %>
        calculateTotal(<%= product.getProductId() %>);
    <% } %>
    
});

// Function to calculate overall total
function calculateOverallTotal() {
    var overallTotal = 0;
    console.log("Calculating overall total");
    <% for (Product product : products) { %>
        var productId = <%= product.getProductId() %>;
        var quantityInput = document.getElementById("quantityInput_" + productId);
        var quantity = parseInt(quantityInput.innerText);
        var productPrice = parseFloat(document.getElementById("productPrice_" + productId).innerText.split(" ")[0]);
        var totalAmount = quantity * productPrice;
        overallTotal += totalAmount;
    <% } %>
    

    console.log("Overall Total: " + overallTotal.toFixed(2));
    return overallTotal.toFixed(2); // Round to 2 decimal places
}

// Function to update cart total
function updateCartTotal() {
    var cartTotalAmount = calculateOverallTotal();
    console.log("Updating Cart Total: INR " + cartTotalAmount);
    var elements = document.getElementsByClassName("cartTotalAmount");
    for (var i = 0; i < elements.length; i++) {
        elements[i].innerText = "INR " + cartTotalAmount;
    }
}

// Function to calculate individual total for a product
function calculateTotal(productId) {
    console.log("Calculating Total for Product ID: " + productId);
    var quantityInput = document.getElementById("quantityInput_"+productId);
    console.log(quantityInput);
    
    var quantity = parseInt(quantityInput.innerText);
    
    var productPrice = parseFloat(document.getElementById("productPrice_" + productId).innerText);
    var totalAmount = quantity * productPrice;
    console.log("Total Amount for Product ID " + productId + ": " + totalAmount.toFixed(2));
    document.getElementById("totalAmount_" + productId).innerText = totalAmount.toFixed(2) + " INR";
    updateCartTotal();
 // Inside the calculateTotal function
    console.log("Quantity for Product ID " + productId + ": " + quantity);

}

$(document).ready(function() {
    // Handle click event for place order button
    $('#placeOrderButton').click(function() {
        // Extract form data
        var formData = {
            firstName: $('#firstName').val(),
            lastName: $('#lastName').val(),
            companyName: $('#companyName').val(),
            address: $('#address').val(),
            townCity: $('#townCity').val(),
            country: $('#country').val(),
            postcode: $('#postcode').val(),
            mobile: $('#mobile').val(),
            email: $('#email').val(),
            notes: $('#notes').val(),
            paymentMethod: $('input[name="paymentMethod"]:checked').val() // Assuming PaymentMethod is the name of the checkboxes group
            // Add additional form fields as needed
        };

        // Send form data to checkout servlet using AJAX
        $.ajax({
            type: 'POST',
            url: 'CheckoutServlet', // Change to the actual URL of your checkout servlet
            data: formData,
            success: function(response) {
                // Handle successful response (if needed)
                alert('Order placed successfully!');
                window.location.href = "OrderedPlaced.jsp";
            },
            error: function(xhr, status, error) {
                // Handle error response
                console.error(xhr.responseText);
                // You can display an error message to the user or redirect them to an error page
                // For simplicity, let's redirect to an error page
                window.location.href = "error.jsp";
            }
        });
    });
});
</script>

    
    </body>

</html>