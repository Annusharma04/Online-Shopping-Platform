<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<jsp:include page="View/Header.jsp" />
<!-- ***** Product Area Starts ***** -->
<section class="section" id="product">
    <div class="container">
        <div class="row">
            <div class="col-lg-8">
                <div class="left-images">
                    <img src="<%=request.getParameter("productImageUrl")%>" alt="">
                </div>
            </div>
            <div class="col-lg-4">
                <div class="right-content">
                    <h4><%= request.getParameter("productName") %></h4>
                    <span class="price">INR<%= request.getParameter("productPrice") %></span>
                    <ul class="stars">
                        <!-- Add stars as needed -->
                    </ul>
                    <span><%= request.getParameter("productDescription") %></span>
                    <!-- Add more product details as needed -->
                    <div class="quantity-content">
                        <div class="left-content">
                            <h6>No. of Orders</h6>
                        </div>
                        <div class="right-content">
                            <div class="quantity buttons_added">
                                <input type="button" value="-" class="minus" onclick="decrementQuantity()">
                                <input type="number" step="1" min="1" max="" name="quantity" value="1" title="Qty" class="input-text qty text" size="4" pattern="" inputmode="" onchange="calculateTotal()">
                                <input type="button" value="+" class="plus" onclick="incrementQuantity()">
                            </div>
                        </div>
                    </div>
                    <div class="total">
                        <h4>Total: INR &nbsp<h4 id="totalAmount"><%= request.getParameter("productPrice") %></h4></h4>
                        <div class="main-border-button"><a href="#" onclick="addToCart()">Add To Cart</a></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- ***** Product Area Ends ***** -->

<!-- Script for AJAX request -->
<script>


function addToCart() {
    var productId = '<%= request.getParameter("productId") %>';
    var quantity = document.getElementsByName("quantity")[0].value;

    var xhr = new XMLHttpRequest();
    xhr.open("POST", "AddToCartServlet", true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4 && xhr.status === 200) {
            var response = JSON.parse(xhr.responseText);
            if (response.success) {
                // Product added successfully

                alert(response.message);
            } else {
                // Product is out of stock
                alert(response.message);
            }
        }
    };
    xhr.send("product_id=" + productId + "&quantity=" + quantity);
}


    function calculateTotal() {
        var price = <%= request.getParameter("productPrice") %>;
        var quantity = document.getElementsByName("quantity")[0].value;
        var total = price * quantity;
        document.getElementById("totalAmount").innerText = total.toFixed(2);
    }

    function incrementQuantity() {
        var quantityInput = document.getElementsByName("quantity")[0];
        var currentQuantity = parseInt(quantityInput.value);
        quantityInput.value = currentQuantity + 1;
        calculateTotal();
    }

    function decrementQuantity() {
        var quantityInput = document.getElementsByName("quantity")[0];
        var currentQuantity = parseInt(quantityInput.value);
        if (currentQuantity > 1) {
            quantityInput.value = currentQuantity - 1;
            calculateTotal();
        }
    }
</script>
    